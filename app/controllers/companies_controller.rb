class CompaniesController < ApplicationController
  def index
    @companies = Company.all

    respond_to do |format|
      format.html
      format.csv {send_data @companies.to_csv }
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
    @contacts = Person.where(id: WorkHistory.where(company_id: params[:id]).pluck(:person_id)).order("name ASC")
    @nbp_buyers = Nbp.where(id:(NbpCompany.where(company_id: @company.id).pluck(:nbp_id)).uniq).order("name ASC")

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
  def destroy
    @subsidiary = Subsidiary.find(params[:id])

    @parent = @subsidiary.parent

    redirect_to "/companies/#{@parent.id}", :notice => "Deal deleted."
  end
  
  def import
    Company.import(params[:file])
    redirect_to "/companies/", notice: "Companies imported"
  end
end
