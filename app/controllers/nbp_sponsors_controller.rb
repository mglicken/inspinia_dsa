class NbpSponsorsController < ApplicationController

#before_action :ensure_access

  def ensure_access
    if current_user.access_id.present?
      if current_user.access_id > 3
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

    if @nbp_sponsor.save
      redirect_to "/nbps/#{@nbp_sponsor.nbp_id}/", :notice => "Sponsor added successfully to NBP."
    else
      render 'new'
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

    if @nbp_sponsor.save
      redirect_to "/nbps/#{@nbp_sponsor.nbp_id}/", :notice => "Sponsor updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @nbp_sponsor = NbpSponsor.find(params[:id])

    @nbp_sponsor.destroy

    redirect_to "/nbps", :notice => "NBP Sponsor deleted."
  end

  def import
    NbpSponsor.import(params[:file])
    redirect_to "/models/", notice: "NBP Sponsors imported."
  end
end
