class CipSponsorsController < ApplicationController

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
    @cip_sponsors = CipSponsor.all

    respond_to do |format|
      format.html
      format.csv {send_data @cip_sponsors.to_csv }
    end
  end


  def show
    @cip_sponsor = CipSponsor.find(params[:id])
  end

  def new
    @cip_sponsor = CipSponsor.new
  end

  def create
    @cip_sponsor = CipSponsor.new

    @cip_sponsor.cip_id = params[:cip_id]
    @cip_sponsor.sponsor_id = params[:sponsor_id]
    @ioi = Ioi.new
    @ioi.name = @cip_sponsor.cip.deal.sponsor.name + " / " + @cip_sponsor.sponsor.name + " IOI"
    @ioi.deal_id = @cip_sponsor.cip.deal_id
    @ioi.ioi_date = Date.current
    @ioi.save
    @cip_sponsor.ioi_id = params[:ioi_id]

    if @cip_sponsor.save
      redirect_to "/cips/#{@cip_sponsor.cip_id}", :notice => "CIP Sponsor created successfully."
    else
      render 'new'
    end
  end

  def create_by_name
    @cip = Cip.find(params[:cip_id])
    @sponsor_name = params[:name]
    @cip_sponsor = CipSponsor.new
    @cip_sponsor.cip_id = @cip.id
    if Sponsor.find_by(name: @sponsor_name).present?
      @sponsor = Sponsor.find_by(name: @sponsor_name)
      @cip_sponsor.sponsor_id = @sponsor.id
    else
      @sponsor = Sponsor.new
      @sponsor.name = @sponsor_name
      @sponsor.save
      @cip_sponsor.sponsor_id = @sponsor.id
    end

    if @cip_sponsor.save
      redirect_to "/cips/#{ params[:cip_id] }/sponsors", :notice => "\"#{@sponsor_name}\" added to \"#{@cip.name}\" successfully."
    else
      render 'new'
    end
  end

  def edit
    @cip_sponsor = CipSponsor.find(params[:id])
  end

  def update
    @cip_sponsor = CipSponsor.find(params[:id])

    @cip_sponsor.cip_id = params[:cip_id]
    @cip_sponsor.sponsor_id = params[:sponsor_id]
    @cip_sponsor.ioi_id = params[:ioi_id]

    if @cip_sponsor.save
      redirect_to "/cip_sponsors/#{@cip_sponsor.id}/", :notice => "CIP Sponsor updated successfully!"
    else
      render 'edit'
    end
  end

  def update_status

    respond_to do |format|
      format.js do
        render('update.js.erb')
      end
    end
  end

  def destroy
    @cip_sponsor = CipSponsor.find(params[:id])

    @cip_sponsor.destroy

    redirect_to "/cip_sponsors/#{@cip_sponsor.id}/", :notice => "CIP Sponsor deleted."
  end
  
  def import
    CipSponsor.import(params[:file])
    redirect_to "/models/", notice: "CIP Sponsors imported"
  end
end
