class FundCompaniesController < ApplicationController

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
    @fund_companies = FundCompany.all

    respond_to do |format|
      format.html
      format.csv {send_data @fund_companies.to_csv }
    end
  end

  def show
    @fund_companies = FundCompany.all
    @fund_company = FundCompany.find(params[:id])
  end

  def new
    @fund_company = FundCompany.new
  end

  def create
    @fund_company = FundCompany.new
    @fund_company.fund_id = params[:fund_id]
    @fund_company.company_id = params[:company_id]
    @fund_company.acquisition_date = params[:acquisition_date]
    @fund_company.acquisition_price = params[:acquisition_price]
    @fund_company.link = params[:link]
 
    respond_to do |format|
      format.html do
        if @fund_company.save
          redirect_to "/funds/#{ params[:fund_id] }", :notice => "Fund Company added successfully."
        else
          render 'new'
        end
      end
        
      format.js do
        @fund_company.save
        render('create.js.erb')
      end

    end
  end

  def edit
    @fund_company = FundCompany.find(params[:id])
  end

  def update
    @fund_company = FundCompany.find(params[:id])

    @fund_company.fund_id = params[:fund_id]
    @fund_company.company_id = params[:company_id]
    @fund_company.acquisition_date = params[:acquisition_date]
    @fund_company.acquisition_price = params[:acquisition_price]
    @fund_company.link = params[:link]

    if @fund_company.save
      redirect_to "/funds/#{@fund_company.fund_id}/", :notice => "Fund Company updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @fund_company = FundCompany.find(params[:id])
    @fund_company.destroy

    respond_to do |format|
      format.html do
        redirect_to "/fund_companies/", :notice => "Fund Company deleted."
      end
      format.js do
        render('destroy.js.erb')
      end
    end
  end

  def import
    FundCompany.import(params[:file])
    redirect_to "/models/", notice: "Fund Companies imported"
  end
end
