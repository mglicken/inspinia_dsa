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

  def index_query
    @company = Company.find(params[:company_id])
    @query_locations = @company.locations
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
    @company = Company.find(params[:company_id])
    @location.owned = params[:owned]
    @location.leased = params[:leased]
    @location.name = params[:name]
    @location.address = params[:address]
    @location.city = params[:city]
    @location.state = params[:state]
    @location.zip = params[:zip]
    @location.phone = params[:phone]
    @location.web_address = params[:web_address]
    if @location.web_address[0..3] == "http" || @location.web_address == ""

    else
      @location.web_address = "http://#{params[:web_address]}"
    end

    if @location.save
      @company_location = CompanyLocation.new
      @company_location.company_id = @company.id
      @company_location.location_id = @location.id
      @company_location.save

      redirect_to "/companies/#{@company.id}", :notice => "Location created successfully."
    else
      render 'new'
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])

    @location.name = params[:name]
    @location.address = params[:address]
    @location.city = params[:city]
    @location.state = params[:state]
    @location.zip = params[:zip]
    @location.phone = params[:phone]
    if params[:web_address][0..3] == "http" || params[:web_address] == ""
      @location.web_address = params[:web_address]
    else
      @location.web_address = "http://#{params[:web_address]}"
    end
    if @location.save
      redirect_to "/locations/#{@location.id}", :notice => "Location updated successfully."
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
