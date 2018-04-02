class DealFollowsController < ApplicationController

#before_action :ensure_access

  def ensure_access
    if current_user.access_id.present?
      if current_user.access_id <= 3
        redirect_to root_url, :alert => "Not Authorized"
      end
    end
  end

  def index
    @deal_follows = DealFollow.all

    respond_to do |format|
      format.html
      format.csv {send_data @deal_follows.to_csv }
    end
  end

  def show
    @deal_follow = DealFollow.find(params[:id])
  end

  def new
    @deal_follow = DealFollow.new
  end

  def create
    @deal_follow = DealFollow.new

    @deal_follow.deal_id = params[:deal_id]
    @deal_follow.user_id = params[:user_id]
 
    respond_to do |format|
      format.html do
        if @deal_follow.save
          redirect_to "/deals/#{ params[:deal_id] }", :notice => "Deal followed."
        else
          render 'new'
        end
      end
        
      format.js do
        @deal_follow.save
        render('create_follow.js.erb')
      end
    end
  end

  def edit
    @deal_follow = DealFollow.find(params[:id])
  end

  def update
    @deal_follow = DealFollow.find(params[:id])

    @deal_follow.user_id = params[:user_id]
    @deal_follow.deal_id = params[:deal_id]


    if @deal_follow.save
      redirect_to "/deal_follows/#{@deal_follow.id}/", :notice => "Deal Follow updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @deal_follow = DealFollow.find(params[:id])
    @deal_follow.destroy

    respond_to do |format|
      format.html do
        redirect_to "/deals/#{params[:id]}", :notice => "Deal unfollowed." 
      end
      format.js do
        render('destroy_follow.js.erb')
      end
    end
  end

  def import
    DealFollow.import(params[:file])
    redirect_to "/models/", notice: "Deal Follows imported"
  end
end
