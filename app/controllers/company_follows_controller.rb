class CompanyFollowsController < ApplicationController

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
    @company_follows = CompanyFollow.all

    respond_to do |format|
      format.html
      format.csv {send_data @company_follows.to_csv }
    end
  end

  def show
    @company_follow = CompanyFollow.find(params[:id])
  end

  def new
    @company_follow = CompanyFollow.new
  end

  def create
    @company_follow = CompanyFollow.new

    @company_follow.company_id = params[:company_id]
    @company_follow.user_id = params[:user_id]
 
    respond_to do |format|
      format.html do
        if @company_follow.save
          redirect_to "/companies/#{ params[:company_id] }", :notice => "Company followed."
        else
          render 'new'
        end
      end
        
      format.js do
        @company_follow.save
        render('create_follow.js.erb')
      end
    end
  end

  def edit
    @company_follow = CompanyFollow.find(params[:id])
  end

  def update
    @company_follow = CompanyFollow.find(params[:id])

    @company_follow.user_id = params[:user_id]
    @company_follow.company_id = params[:company_id]


    if @company_follow.save
      redirect_to "/company_follows/#{@company_follow.id}/", :notice => "Company Follow updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @company_follow = CompanyFollow.find(params[:id])
    @company_follow.destroy

    respond_to do |format|
      format.html do
        redirect_to "/companies/#{params[:id]}", :notice => "Company unfollowed." 
      end
      format.js do
        render('destroy_follow.js.erb')
      end
    end
  end

  def import
    CompanyFollow.import(params[:file])
    redirect_to "/models/", notice: "Company Follows imported"
  end
end
