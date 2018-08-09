class CompanyLocationsController < ApplicationController

before_action :ensure_admin_access,  only: [:index, :show, :import]
before_action :ensure_banker_access,  only: [:new, :create, :edit, :update, :destroy]


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
    @company_locations = CompanyLocation.all

    respond_to do |format|
      format.html
      format.csv {send_data @company_locations.to_csv }
    end
  end


  def show
    @company_location = CompanyLocation.find(params[:id])
  end

  def new
    @company_location = CompanyLocation.new
  end

  def create
    @company_location = CompanyLocation.new


    @company_location.location_id = params[:location_id]
    @company_location.company_id = params[:company_id]

    if @company_location.save
      redirect_to "/companies/#{@company_location.company_id}", :notice => "Company Location created successfully."
    else
      render 'new'
    end
  end

  def edit
    @company_location = CompanyLocation.find(params[:id])
  end

  def update
    @company_location = CompanyLocation.find(params[:id])

    @company_location.location_id = params[:location_id]
    @company_location.company_id = params[:company_id]

    if @company_location.save
      redirect_to "/companies/#{@company_location.company_id}", :notice => "Company Location updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @company_location = CompanyLocation.find(params[:id])
    @company = @company_location.company
    @company_location.destroy

    redirect_to "/companies/#{@company.id}", :notice => "Company Location deleted."
  end
  
  def import
    CompanyLocation.import(params[:file])
    redirect_to "/models/", notice: "Company Locations imported"
  end
end
