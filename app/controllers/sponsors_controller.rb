class SponsorsController < ApplicationController

before_action :ensure_admin_access,  only: [:index, :import]
before_action :ensure_banker_access,  only: [:new, :create, :follow, :unfollow, :edit, :update, :destroy]
before_action :ensure_view_access,  only: [:show, :search]

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
    @sponsors = Sponsor.all

    respond_to do |format|
      format.html
      format.csv {send_data @sponsors.to_csv }
    end
  end

  def index_query
    @query_sponsors = Sponsor.where("lower(name) LIKE ?", "%#{params[:term].downcase}%").order("name asc")
    respond_to do |format|
      format.json {send_data @query_sponsors.map(&:name)}
    end
  end

  def search
    @text = params[:search].downcase
    sponsor_ids = []
    Sponsor.all.each do |sponsor|
      if sponsor.name.downcase.include? @text
        sponsor_ids.push(sponsor.id)
      end
    end
    @sponsors=Sponsor.where(id: sponsor_ids)
  end

  def follow
    @sponsor_follow = SponsorFollow.new

    @sponsor_follow.sponsor_id = params[:sponsor_id]
    @sponsor_follow.user_id = current_user.id
 
    respond_to do |format|
      format.html do
        if @sponsor_follow.save
          redirect_to "/sponsors/#{ params[:sponsor_id] }", :notice => "Sponsor followed."
        else
          render 'new'
        end
      end
        
      format.js do
        @sponsor_follow.save
        render('create_follow.js.erb')
      end
    end
  end

  def unfollow
    @sponsor_follow = SponsorFollow.where(sponsor_id: params[:id], user_id: current_user.id).first
    @sponsor_follow.destroy

    respond_to do |format|
      format.html do
        redirect_to "/sponsors/#{params[:id]}", :notice => "Sponsor unfollowed." 
      end
      format.js do
        render('destroy_follow.js.erb')
      end
    end
  end

  def show
    @sponsor = Sponsor.find(params[:id])
    @followed = SponsorFollow.where(sponsor_id: params[:id],user_id: current_user.id).present?
    @funds = @sponsor.funds
    @companies = Company.where(id: FundCompany.where(fund_id: @funds.ids).pluck(:company_id))
    @deals = Deal.where(company_id: @companies.ids)
    @notes = @sponsor.notes
    @people = Person.where(id: SponsorHistory.where(sponsor_id: params[:id]).pluck(:person_id)).order("name ASC")

    @contacts = Person.where(id: @sponsor.sponsor_histories.joins(:person).order("name ASC").pluck(:person_id))
    @nbp_sponsors = @sponsor.nbp_sponsors.joins(:sponsor).order("name ASC")
    @teaser_sponsors = @sponsor.teaser_sponsors.joins(:sponsor).order("name ASC")
    @cip_sponsors = @sponsor.cip_sponsors.joins(:sponsor).order("name ASC")
    @mp_sponsors = @sponsor.mp_sponsors.joins(:sponsor).order("name ASC")
    @country == params[:country]

    if @country == "United States of America"
      @scope = "usa"
      @locations = @sponsor.locations.where(country: "United States of America")
    elsif @country == "Aruba"
      @scope = "abw"
      @locations = @sponsor.locations.where(country: "Aruba")
    elsif @country == "Afghanistan"
      @scope = "afg"
      @locations = @sponsor.locations.where(country: "Afghanistan")
    elsif @country == "Angola"
      @scope = "ago"
      @locations = @sponsor.locations.where(country: "Angola")
    elsif @country == "Anguilla"
      @scope = "aia"
      @locations = @sponsor.locations.where(country: "Anguilla")
    elsif @country == "Aland Islands"
      @scope = "ala"
      @locations = @sponsor.locations.where(country: "Anguilla")
    elsif @country == "Albania"
      @scope = "alb"
      @locations = @sponsor.locations.where(country: "Albania")
    elsif @country == "Andorra"
      @scope = "and"
      @locations = @sponsor.locations.where(country: "Andorra")
    elsif @country == "United Arab Emirates"
      @scope = "are"
      @locations = @sponsor.locations.where(country: "United Arab Emirates")
    elsif @country == "Argentina"
      @scope = "arg"
      @locations = @sponsor.locations.where(country: "Argentina")
    elsif @country == "Armenia"
      @scope = "arm"
      @locations = @sponsor.locations.where(country: "Armenia")
    elsif @country == "American Samoa"
      @scope = "asm"
      @locations = @sponsor.locations.where(country: "American Samoa")
    elsif @country == "Antarctica"
      @scope = "ata"
      @locations = @sponsor.locations.where(country: "Antarctica")
    elsif @country == "French Southern Territories"
      @scope = "atf"
      @locations = @sponsor.locations.where(country: "French Southern Territories")
    elsif @country == "XXXXXX"
      @scope = "xxx"
      @locations = @sponsor.locations.where(country: "XXXXXX")
    elsif @country == "XXXXXX"
      @scope = "xxx"
      @locations = @sponsor.locations.where(country: "XXXXXX")
    elsif @country == "XXXXXX"
      @scope = "xxx"
      @locations = @sponsor.locations.where(country: "XXXXXX")
    elsif @country == "XXXXXX"
      @scope = "xxx"
      @locations = @sponsor.locations.where(country: "XXXXXX")
    elsif @country == "XXXXXX"
      @scope = "xxx"
      @locations = @sponsor.locations.where(country: "XXXXXX")
    elsif @country == "XXXXXX"
      @scope = "xxx"
      @locations = @sponsor.locations.where(country: "XXXXXX")
    elsif @country == "XXXXXX"
      @scope = "xxx"
      @locations = @sponsor.locations.where(country: "XXXXXX")
    elsif @country == "XXXXXX"
      @scope = "xxx"
      @locations = @sponsor.locations.where(country: "XXXXXX")
    elsif @country == "XXXXXX"
      @scope = "xxx"
      @locations = @sponsor.locations.where(country: "XXXXXX")
    elsif @country == "XXXXXX"
      @scope = "xxx"
      @locations = @sponsor.locations.where(country: "XXXXXX")
    elsif @country == "XXXXXX"
      @scope = "xxx"
      @locations = @sponsor.locations.where(country: "XXXXXX")
    elsif @country == "XXXXXX"
      @scope = "xxx"
      @locations = @sponsor.locations.where(country: "XXXXXX")
    elsif @country == "XXXXXX"
      @scope = "xxx"
      @locations = @sponsor.locations.where(country: "XXXXXX")
    elsif @country == "XXXXXX"
      @scope = "xxx"
      @locations = @sponsor.locations.where(country: "XXXXXX")
    elsif @country == "Venezuela"
      @scope = "ven"
      @locations = @sponsor.locations.where(country: "Venezuela")
    elsif @country == "Brazil"
      @scope = "bra"
      @locations = @sponsor.locations.where(country: "Brazil")
    elsif @country == "Canada"
      @scope = "can"
      @locations = @sponsor.locations.where(country: "Canada")
    else
      @country = "world"
      @scope = "world"
      @locations = @sponsor.locations
    end
  end

  def new
    @sponsor = Sponsor.new
  end

  def create
    @sponsor = Sponsor.new

    @sponsor.name = params[:name]
    @sponsor.tier = params[:tier]
    @sponsor.sponsor_type = params[:sponsor_type]
    @sponsor.rco_id = params[:rco_id]
    @sponsor.co_id = params[:co_id]
    @sponsor.address = params[:address]
    @sponsor.city = params[:city]
    @sponsor.state = params[:state]
    @sponsor.zip = params[:zip]
    @sponsor.phone = params[:phone]
    @sponsor.web_address = params[:web_address]
    @sponsor.linkedin_url = params[:linkedin_url]
    @sponsor.description = params[:description]
    @sponsor.description_date = Date.today

    if @sponsor.web_address[0..3] == "http" || @sponsor.web_address == ""

    else
      @sponsor.web_address "http://" + params[:web_address]
    end

    if @sponsor.save
      redirect_to "/sponsors/#{@sponsor.id}", :notice => "Sponsor created successfully."
    else
      render 'new'
    end
  end

  def edit
    @sponsor = Sponsor.find(params[:id])
  end

  def update
    @sponsor = Sponsor.find(params[:id])
    @sponsor.name = params[:name]
    @sponsor.tier = params[:tier]
    @sponsor.sponsor_type = params[:sponsor_type]
    @sponsor.rco_id = params[:rco_id]
    @sponsor.co_id = params[:co_id]
    @sponsor.address = params[:address]
    @sponsor.city = params[:city]
    @sponsor.state = params[:state]
    @sponsor.zip = params[:zip]
    @sponsor.phone = params[:phone]
    @sponsor.web_address = params[:web_address]
    @sponsor.linkedin_url = params[:linkedin_url]
    @sponsor.description = params[:description]
    if @sponsor.description != params[:description]
      @sponsor.description_date = Date.today
    end    
    if @sponsor.web_address[0..3] == "http" 

    else
      @sponsor.web_address = "http://" + params[:web_address]
    end
    
    if @sponsor.save
      redirect_to "/sponsors/#{@sponsor.id}", :notice => "Sponsor updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @sponsor = Sponsor.find(params[:id])

    @sponsor.destroy

    redirect_to "/sponsors", :notice => "Sponsor deleted."
  end
  def import
    Sponsor.import(params[:file])
    redirect_to "/models/", notice: "Sponsors imported"
  end

end
