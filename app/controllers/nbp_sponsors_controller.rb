class NbpSponsorsController < ApplicationController
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
      redirect_to "/nbps", :notice => "NBP Sponsor created successfully."
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
      redirect_to "/nbp_sponsors/#{@nbp_sponsor.id}/", :notice => "NBP Sponsor updated successfully!"
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
    redirect_to "/nbp_sponsors/", notice: "NBP Sponsors imported."
  end
end
