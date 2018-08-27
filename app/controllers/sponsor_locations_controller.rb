class SponsorLocationsController < ApplicationController

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
    @sponsor_locations = SponsorLocation.all

    respond_to do |format|
      format.html
      format.csv {send_data @sponsor_locations.to_csv }
    end
  end


  def show
    @sponsor_location = SponsorLocation.find(params[:id])
  end

  def new
    @sponsor_location = SponsorLocation.new
  end

  def create
    @sponsor_location = SponsorLocation.new


    @sponsor_location.location_id = params[:location_id]
    @sponsor_location.sponsor_id = params[:sponsor_id]

    if @sponsor_location.save
      redirect_to "/sponsors/#{@sponsor_location.sponsor_id}", :notice => "Sponsor Location created successfully."
    else
      render 'new'
    end
  end

  def edit
    @sponsor_location = SponsorLocation.find(params[:id])
  end

  def update
    @sponsor_location = SponsorLocation.find(params[:id])

    @sponsor_location.location_id = params[:location_id]
    @sponsor_location.sponsor_id = params[:sponsor_id]

    if @sponsor_location.save
      redirect_to "/sponsors/#{@sponsor_location.sponsor_id}", :notice => "Sponsor Location updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @sponsor_location = SponsorLocation.find(params[:id])
    @sponsor = @sponsor_location.sponsor
    @sponsor_location.destroy

    redirect_to "/sponsors/#{@sponsor.id}", :notice => "Sponsor Location deleted."
  end
  
  def import
    SponsorLocation.import(params[:file])
    redirect_to "/models/", notice: "Sponsor Locations imported"
  end
end
