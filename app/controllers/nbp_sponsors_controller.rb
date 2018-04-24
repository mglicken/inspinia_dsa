class NbpSponsorsController < ApplicationController

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
    @nbp_sponsors = NbpSponsor.all
        respond_to do |format|
      format.html
      format.csv {send_data @nbp_sponsors.to_csv }
    end
  end

  def show
    @nbp_sponsor = NbpSponsor.find(params[:id])
  end

  def new
    @nbp_sponsor = NbpSponsor.new
  end

  def create
    @nbp_sponsor = NbpSponsor.new


    @nbp_sponsor.sponsor_id = params[:sponsor_id]
    @nbp_sponsor.nbp_id = params[:nbp_id]
    @nbp_sponsor.featured = params[:featured]
    @nbp_sponsor.rationale = params[:rationale]
    @nbp_sponsor.note = params[:note]


    if @nbp_sponsor.save
      redirect_to "/nbps/#{@nbp_sponsor.nbp_id}/sponsors/", :notice => "Sponsor added successfully to NBP."
    else
      render 'new'
    end
  end

  def create_by_name
    @nbp = Nbp.find(params[:nbp_id])
    @sponsor_name = params[:name]
    @nbp_sponsor = NbpSponsor.new
    @nbp_sponsor.nbp_id = @nbp.id

    if Sponsor.find_by(name: @sponsor_name).present?
      @sponsor = Sponsor.find_by(name: @sponsor_name)
      @nbp_sponsor.sponsor_id = @sponsor.id
    else
      @sponsor = Sponsor.new
      @sponsor.name = @sponsor_name
      @sponsor.save
      @nbp_sponsor.sponsor_id = @sponsor.id
    end

    if @nbp_sponsor.save
      redirect_to "/nbps/#{ params[:nbp_id] }/sponsors", :notice => "\"#{@sponsor_name}\" added successfully."
    else
      redirect_to "/nbps/#{ params[:nbp_id] }/sponsors", :notice => "\"#{@sponsor_name}\" already included."
    end
  end

  def edit
    @nbp_sponsor = NbpSponsor.find(params[:id])
  end

  def update
    @nbp_sponsor = NbpSponsor.find(params[:id])

    @nbp_sponsor.sponsor_id = params[:sponsor_id]
    @nbp_sponsor.nbp_id = params[:nbp_id]
    @nbp_sponsor.featured = params[:featured]
    @nbp_sponsor.rationale = params[:rationale]
    @nbp_sponsor.note = params[:note]

    if @nbp_sponsor.save
      redirect_to "/nbps/#{@nbp_sponsor.nbp_id}/sponsors", :notice => "Sponsor updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @nbp_sponsor = NbpSponsor.find(params[:id])

    @nbp_sponsor.destroy

    redirect_to "/nbps/#{@nbp_sponsor.nbp_id}/sponsors", :notice => "NBP Sponsor deleted."
  end

  def import
    NbpSponsor.import(params[:file])
    redirect_to "/models/", notice: "NBP Sponsors imported."
  end
end
