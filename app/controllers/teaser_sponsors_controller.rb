class TeaserSponsorsController < ApplicationController

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
    @teaser_sponsors = TeaserSponsor.all

    respond_to do |format|
      format.html
      format.csv {send_data @teaser_sponsors.to_csv }
    end
  end


  def show
    @teaser_sponsor = TeaserSponsor.find(params[:id])
  end

  def new
    @teaser_sponsor = TeaserSponsor.new
  end

  def create
    @teaser_sponsor = TeaserSponsor.new

    @teaser_sponsor.teaser_id = params[:teaser_id]
    @teaser_sponsor.sponsor_id = params[:sponsor_id]

    @nda = Nda.new
    @nda.name = @teaser_sponsor.teaser.deal.sponsor.name + " / " + @teaser_sponsor.sponsor.name + " NDA"
    @nda.deal_id = @teaser_sponsor.teaser.deal_id
    @nda.nda_date = @teaser_sponsor.teaser.teaser_date
    @nda.save

    @teaser_sponsor.nda_id = @nda.id

    if @teaser_sponsor.save
      redirect_to "/teasers/#{@teaser_sponsor.teaser_id}", :notice => "Teaser Sponsor created successfully."
    else
      render 'new'
    end
  end

  def create_by_name
    @teaser = Teaser.find(params[:teaser_id])
    @sponsor_name = params[:name]
    @teaser_sponsor = TeaserSponsor.new
    @teaser_sponsor.teaser_id = @teaser.id
    if Sponsor.find_by(name: @sponsor_name).present?
      @sponsor = Sponsor.find_by(name: @sponsor_name)
      @teaser_sponsor.sponsor_id = @sponsor.id
    else
      @sponsor = Sponsor.new
      @sponsor.name = @sponsor_name
      @sponsor.save
      @teaser_sponsor.sponsor_id = @sponsor.id
    end
    @nda = Nda.new
    @nda.name = @teaser.deal.company.name + " / " + @sponsor.name + " NDA"
    @nda.deal_id = @teaser.deal_id
    @nda.nda_date = @teaser.teaser_date
    @nda.save

    @teaser_sponsor.nda_id = @nda.id

    if @teaser_sponsor.save
      redirect_to "/teasers/#{ params[:teaser_id] }/sponsors", :notice => "\"#{@sponsor_name}\" added to \"#{@teaser.name}\" successfully."
    else
      render 'new'
    end
  end

  def edit
    @teaser_sponsor = TeaserSponsor.find(params[:id])
  end

  def update
    @teaser_sponsor = TeaserSponsor.find(params[:id])

    @teaser_sponsor.teaser_id = params[:teaser_id]
    @teaser_sponsor.sponsor_id = params[:sponsor_id]
    @teaser_sponsor.nda_id = params[:nda_id]

    if @teaser_sponsor.save
      redirect_to "/teaser_sponsors/#{@teaser_sponsor.id}/", :notice => "Teaser Sponsor updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @teaser_sponsor = TeaserSponsor.find(params[:id])

    @teaser_sponsor.destroy

    redirect_to "/teaser_sponsors/#{@teaser_sponsor.id}/", :notice => "Teaser Sponsor deleted."
  end
  
  def import
    TeaserSponsor.import(params[:file])
    redirect_to "/models/", notice: "Teaser Sponsors imported"
  end
end
