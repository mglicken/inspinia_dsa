class EngagementSponsorsController < ApplicationController

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
    @engagement_sponsors = EngagementSponsor.all

    respond_to do |format|
      format.html
      format.csv {send_data @engagement_sponsors.to_csv }
    end
  end

  def show
    @engagement_sponsor = EngagementSponsor.find(params[:id])
  end

  def new
    @engagement_sponsor = EngagementSponsor.new
  end

  def create
    @engagement_sponsor = EngagementSponsor.new

    @engagement_sponsor.deal_id = params[:deal_id]
    @engagement_sponsor.sponsor_id = params[:sponsor_id]
 
    respond_to do |format|
      format.html do
        if @engagement_sponsor.save
          redirect_to "/deals/#{ params[:deal_id] }", :notice => "Engagement Sponsor added."
        else
          render 'new'
        end
      end
        
      format.js do
        @engagement_sponsor.save
        render('create_follow.js.erb')
      end
    end
  end

  def edit
    @engagement_sponsor = EngagementSponsor.find(params[:id])
  end

  def update
    @engagement_sponsor = EngagementSponsor.find(params[:id])

    @engagement_sponsor.sponsor_id = params[:sponsor_id]
    @engagement_sponsor.deal_id = params[:deal_id]


    if @engagement_sponsor.save
      redirect_to "/engagement_sponsors/#{@engagement_sponsor.id}/", :notice => "Engagement Sponsor updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @engagement_sponsor = EngagementSponsor.find(params[:id])
    @engagement_sponsor.destroy

    respond_to do |format|
      format.html do
        redirect_to "/deals/#{params[:id]}", :notice => "Engagement Sponsor Removed." 
      end
      format.js do
        render('destroy_follow.js.erb')
      end
    end
  end

  def import
    EngagementSponsor.import(params[:file])
    redirect_to "/models/", notice: "Engagement Sponsor imported"
  end
end
