class SponsorFollowsController < ApplicationController

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
    @sponsor_follows = SponsorFollow.all

    respond_to do |format|
      format.html
      format.csv {send_data @sponsor_follows.to_csv }
    end
  end

  def show
    @sponsor_follow = SponsorFollow.find(params[:id])
  end

  def new
    @sponsor_follow = SponsorFollow.new
  end

  def create
    @sponsor_follow = SponsorFollow.new

    @sponsor_follow.sponsor_id = params[:sponsor_id]
    @sponsor_follow.user_id = params[:user_id]
 
    respond_to do |format|
      format.html do
        if @sponsor_follow.save
          redirect_to "/sponsors/#{ params[:sponsor_id] }", :notice => "Sponsor followed."
        else
          render 'new'
        end
      end
        
      format.js do
        @sponsor_follow.save
        render('create_follow.js.erb')
      end
    end
  end

  def edit
    @sponsor_follow = SponsorFollow.find(params[:id])
  end

  def update
    @sponsor_follow = SponsorFollow.find(params[:id])

    @sponsor_follow.user_id = params[:user_id]
    @sponsor_follow.sponsor_id = params[:sponsor_id]


    if @sponsor_follow.save
      redirect_to "/sponsor_follows/#{@sponsor_follow.id}/", :notice => "Sponsor Follow updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @sponsor_follow = SponsorFollow.find(params[:id])
    @sponsor_follow.destroy

    respond_to do |format|
      format.html do
        redirect_to "/sponsors/#{params[:id]}", :notice => "Sponsor unfollowed." 
      end
      format.js do
        render('destroy_follow.js.erb')
      end
    end
  end

  def import
    SponsorFollow.import(params[:file])
    redirect_to "/models/", notice: "Sponsor Follows imported"
  end
end
