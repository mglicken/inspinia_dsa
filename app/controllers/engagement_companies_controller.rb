class EngagementCompaniesController < ApplicationController

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
    @engagement_companies = EngagementCompany.all

    respond_to do |format|
      format.html
      format.csv {send_data @engagement_companies.to_csv }
    end
  end

  def show
    @engagement_company = EngagementCompany.find(params[:id])
  end

  def new
    @engagement_company = EngagementCompany.new
  end

  def create
    @engagement_company = EngagementCompany.new

    @engagement_company.deal_id = params[:deal_id]
    @engagement_company.company_id = params[:company_id]
 
    respond_to do |format|
      format.html do
        if @engagement_company.save
          redirect_to "/deals/#{ params[:deal_id] }", :notice => "Engagement Company added."
        else
          render 'new'
        end
      end
        
      format.js do
        @engagement_company.save
        render('create_follow.js.erb')
      end
    end
  end

  def edit
    @engagement_company = EngagementCompany.find(params[:id])
  end

  def update
    @engagement_company = EngagementCompany.find(params[:id])

    @engagement_company.company_id = params[:company_id]
    @engagement_company.deal_id = params[:deal_id]


    if @engagement_company.save
      redirect_to "/engagement_companies/#{@engagement_company.id}/", :notice => "Engagement Company updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @engagement_company = EngagementCompany.find(params[:id])
    @engagement_company.destroy

    respond_to do |format|
      format.html do
        redirect_to "/deals/#{params[:id]}", :notice => "Engagement Company Removed." 
      end
      format.js do
        render('destroy_follow.js.erb')
      end
    end
  end

  def import
    EngagementCompany.import(params[:file])
    redirect_to "/models/", notice: "Engagement Company imported"
  end
end
