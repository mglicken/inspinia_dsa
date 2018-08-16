class CompaniesController < ApplicationController

before_action :ensure_banker_access,  only: [:new, :create, :follow, :unfollow, :create_subsidiary, :edit, :update, :destroy, :import]
before_action :ensure_view_access,  only: [:index, :search, :show]

  def ensure_admin_access
    if current_user.access_id.present?
      if current_user.access_id > 2
        redirect_to root_url, :alert => "Not Authorized"
      end
    end
  end

  def ensure_banker_access
    if current_user.access_id.present?
      if current_user.access_id > 3
        redirect_to root_url, :alert => "Not Authorized"
      end
    end
  end

  def ensure_view_access
    if current_user.access_id.present?
      if current_user.access_id > 4
        redirect_to root_url, :alert => "Not Authorized"
      end
    end
  end

  def index
    @companies = Company.all

    respond_to do |format|
      format.html
      format.csv {send_data @companies.to_csv }
    end
  end

  def index_query
    @query_companies = Company.where("lower(name) LIKE ?", "%#{params[:term].downcase}%").order("name asc")
    respond_to do |format|
      format.json {send_data @query_companies.map(&:name)}
    end
  end
  
  def nbp_index_query
    @query_companies = Company.where(id: (Company.ids - NbpCompany.where(bucket_id: params[:bucket_id]).pluck(:company_id))).where("lower(name) LIKE ?", "%#{params[:term].downcase}%").order("name asc")
    respond_to do |format|
      format.json {send_data @query_companies.map(&:name)}
    end
  end

  def search
    @text = params[:search].downcase
    company_ids = []
    Company.all.each do |company|
      if company.name.downcase.include? @text
        company_ids.push(company.id)
      end
    end
    @companies=Company.where(id: company_ids)
  end

  def follow
    @company_follow = CompanyFollow.new

    @company_follow.company_id = params[:company_id]
    @company_follow.user_id = current_user.id
 
    respond_to do |format|
      format.html do
        if @company_follow.save
          redirect_to "/companies/#{ params[:company_id] }", :notice => "Company followed."
        else
          render 'new'
        end
      end
        
      format.js do
        @company_follow.save
        render('create_follow.js.erb')
      end
    end
  end

  def unfollow
    @company_follow = CompanyFollow.where(company_id: params[:id], user_id: current_user.id).first
    @company_follow.destroy

    respond_to do |format|
      format.html do
        redirect_to "/companies/#{params[:id]}", :notice => "Company unfollowed." 
      end
      format.js do
        render('destroy_follow.js.erb')
      end
    end
  end

  def show
    @company = Company.find(params[:id])
    @followed = CompanyFollow.where(company_id: params[:id],user_id: current_user.id).present?
    @contacts = Person.where(id: @company.work_histories.joins(:person).order("name ASC").pluck(:person_id))
    @nbp_companies = NbpCompany.where(company_id:  @company.children.ids.push(@company.id) ).joins(:company).order("name ASC")
    @teaser_companies = TeaserCompany.where(company_id:  @company.children.ids.push(@company.id) ).joins(:company).order("name ASC")
    @cip_companies = CipCompany.where(company_id:  @company.children.ids.push(@company.id) ).joins(:company).order("name ASC")
    @mp_companies = MpCompany.where(company_id:  @company.children.ids.push(@company.id) ).joins(:company).order("name ASC")
    @sponsors = Sponsor.where(id: Fund.where(id: FundCompany.where(company_id: (@company.parents.ids.push(@company.id))).pluck(:fund_id)).pluck(:sponsor_id)).order("name ASC")
    
    if params[:country] == "United States of America"
      @scope = "usa"
    elsif params[:country] == "Aruba"
      @scope = "abw"
    elsif params[:country] == "Afghanistan"
      @scope = "afg"
    elsif params[:country] == "Angola"
      @scope = "ago"
    elsif params[:country] == "Anguilla"
      @scope = "aia"
    elsif params[:country] == "Aland Islands"
      @scope = "ala"
    elsif params[:country] == "Albania"
      @scope = "alb"
    elsif params[:country] == "Andorra"
      @scope = "and"
    elsif params[:country] == "United Arab Emirates"
      @scope = "are"
    elsif params[:country] == "Argentina"
      @scope = "arg"
    elsif params[:country] == "Armenia"
      @scope = "arm"
    elsif params[:country] == "American Samoa"
      @scope = "asm"
    elsif params[:country] == "Antarctica"
      @scope = "ata"
    elsif params[:country] == "French Southern Territories"
      @scope = "atf"
    elsif params[:country] == "Canada"
      @scope = "can"
    else
      @scope = "world"
    end
  end

  def new
    @company = Company.new
  end

  def create_subsidiary
    @subsidiary = Subsidiary.new

    @subsidiary.parent_id = params[:parent_id]
    @subsidiary.child_id = params[:child_id]
    @subsidiary.acquisition_date = params[:acquisition_date]
    @subsidiary.acquisition_price = params[:acquisition_price]
    @subsidiary.link = params[:link]

    if @subsidiary.save
      redirect_to "/companies/#{@subsidiary.parent_id}", :notice => "Company created successfully."
    else
      render 'new'
    end
  end

  def create
    @company = Company.new

    @company.name = params[:name]
    @company.revenue = params[:revenue]
    @company.ebitda = params[:ebitda]
    @company.address = params[:address]
    @company.city = params[:city]
    @company.state = params[:state]
    @company.zip = params[:zip]
    @company.phone = params[:phone]
    @company.web_address = params[:web_address]
    if @company.web_address[0..3] == "http" || @company.web_address == ""

    else
      @company.web_address = "http://#{params[:web_address]}"
    end
    @company.linkedin_url = params[:linkedin_url]
    @company.description = params[:description]
    @company.description_date = Date.today
    @company.quote = params[:quote]

    if @company.save
      redirect_to "/companies/#{@company.id}", :notice => "Company created successfully."
    else
      render 'new'
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])

    @company.name = params[:name]
    @company.revenue = params[:revenue]
    @company.ebitda = params[:ebitda]
    @company.address = params[:address]
    @company.city = params[:city]
    @company.state = params[:state]
    @company.zip = params[:zip]
    @company.phone = params[:phone]
    if params[:web_address][0..3] == "http" || params[:web_address] == ""
      @company.web_address = params[:web_address]
    else
      @company.web_address = "http://#{params[:web_address]}"
    end

    @company.linkedin_url = params[:linkedin_url]
    @company.description = params[:description]
    if @company.description != params[:description]
      @company.description_date = Date.today
    end
    @company.quote = params[:quote]
    if @company.save
      redirect_to "/companies/#{@company.id}", :notice => "Company updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @company = Company.find(params[:id])

    @company.destroy

    redirect_to "/companies", :notice => "Company deleted."
  end

  
  def import
    Company.import(params[:file])
    redirect_to "/models/", notice: "Companies imported"
  end
end
