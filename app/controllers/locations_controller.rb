class LocationsController < ApplicationController

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
    @locations = Location.all

    respond_to do |format|
      format.html
      format.csv {send_data @locations.to_csv }
    end
  end

  def company_query
    @company = Company.find(params[:company_id])
    if @country.present?
      if @country == world
        @locations = @company.locations
      else
        @locations = @company.locations.where(country: @country)
      end
    else
      @locations = @company.locations
    end
    @query_locations = []
    @locations.each do |location|
      loc = Hash.new
      loc[:id] = location.id
      loc[:name] = location.name
      loc[:radius] = 7
      loc[:fillKey] = 'active'
      loc[:street] = location.street
      loc[:city] = location.city
      loc[:state] = location.state
      loc[:zip] = location.zip
      loc[:country] = location.country
      loc[:latitude] = location.latitude
      loc[:longitude] = location.longitude
      @query_locations.push(loc)
    end 
    respond_to do |format|
      format.json {send_data @query_locations.to_json}
    end
  end

  def sponsor_query
    @sponsor = Sponsor.find(params[:sponsor_id])
    if @country.present?
      if @country == world
        @locations = @sponsor.locations
      else
        @locations = @sponsor.locations.where(country: @country)
      end
    else
      @locations = @sponsor.locations
    end
    @query_locations = []
    @locations.each do |location|
      loc = Hash.new
      loc[:id] = location.id
      loc[:name] = location.name
      loc[:radius] = 7
      loc[:fillKey] = 'active'
      loc[:street] = location.street
      loc[:city] = location.city
      loc[:state] = location.state
      loc[:zip] = location.zip
      loc[:country] = location.country
      loc[:latitude] = location.latitude
      loc[:longitude] = location.longitude
      @query_locations.push(loc)
    end 
    respond_to do |format|
      format.json {send_data @query_locations.to_json}
    end
  end

  def show
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new
    if params[:company_id] == "zzz"
      @company = Company.none
    else
      @company = Company.find(params[:company_id])
    end
    if params[:sponsor_id] == "zzz"
      @sponsor = Sponsor.none
    else
      @sponsor = Sponsor.find(params[:sponsor_id])
    end
    @location.owned = params[:owned]
    @location.leased = params[:leased]
    @location.name = params[:name]
    @location.street = params[:street]
    @location.city = params[:city]
    @location.state = params[:state]
    @location.zip = params[:zip]
    @location.country = params[:country]
    @location.phone = params[:phone]
    @location.web_address = params[:web_address]
    if @location.web_address[0..3] == "http" || @location.web_address == ""

    else
      @location.web_address = "http://#{params[:web_address]}"
    end
    if @location.save
      if @company.present?
        @company_location = CompanyLocation.new
        @company_location.company_id = @company.id
        @company_location.location_id = @location.id
        @company_location.save

        redirect_to "/companies/#{@company.id}", :notice => "Location created successfully."
      elsif @sponsor.present?
        @sponsor_location = SponsorLocation.new
        @sponsor_location.sponsor_id = @sponsor.id
        @sponsor_location.location_id = @location.id
        @sponsor_location.save

        redirect_to "/sponsors/#{@sponsor.id}", :notice => "Location created successfully."
      end
    else
      render 'new'
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])

    @location.owned = params[:owned]
    @location.leased = params[:leased]
    @location.name = params[:name]
    @location.street = params[:street]
    @location.city = params[:city]
    @location.state = params[:state]
    @location.zip = params[:zip]
    @location.country = params[:country]
    @location.phone = params[:phone]

    if params[:longitude].present? && params[:latitude].present?
      @location.longitude = params[:longitude]
      @location.latitude = params[:latitude]
    end

    if params[:web_address][0..3] == "http" || params[:web_address] == ""
      @location.web_address = params[:web_address]
    else
      @location.web_address = "http://#{params[:web_address]}"
    end

    if @location.save
      if params[:company_id] == "zzz"
      redirect_to "/sponsors/#{@location.sponsor.id}", :notice => "Location updated successfully."
      elsif params[:sponsor_id] == "zzz"
      redirect_to "/companies/#{@location.company.id}", :notice => "Location updated successfully."
      end
    else
      render 'edit'
    end
  end

  def destroy
    @location = Location.find(params[:id])

    @location.destroy

    redirect_to "/locations", :notice => "Location deleted."
  end

  
  def import
    Location.import(params[:file])
    redirect_to "/models/", notice: "Locations imported"
  end
end
