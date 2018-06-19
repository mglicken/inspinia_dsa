class CipCompaniesController < ApplicationController

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
    @cip_companies = CipCompany.all

    respond_to do |format|
      format.html
      format.csv {send_data @cip_companies.to_csv }
    end
  end


  def show
    @cip_company = CipCompany.find(params[:id])
  end

  def new
    @cip_company = CipCompany.new
  end

  def create
    @cip_company = CipCompany.new

    @cip_company.cip_id = params[:cip_id]
    @cip_company.company_id = params[:company_id]
    @ioi = Ioi.new
    @ioi.name = @cip_company.cip.deal.company.name + " / " + @cip_company.company.name + " IOI"
    @ioi.deal_id = @cip_company.cip.deal_id
    @ioi.ioi_date = Date.current
    @ioi.save
    @cip_company.ioi_id = params[:ioi_id]

    if @cip_company.save
      redirect_to "/cips/#{@cip_company.cip_id}", :notice => "CIP Company created successfully."
    else
      render 'new'
    end
  end

  def create_by_name
    @cip = cip.find(params[:cip_id])
    @company_name = params[:name]
    @cip_company = CipCompany.new
    @cip_company.cip_id = @cip.id
    if Company.find_by(name: @company_name).present?
      @company = Company.find_by(name: @company_name)
      @cip_company.company_id = @company.id
    else
      @company = Company.new
      @company.name = @company_name
      @company.save
      @cip_company.company_id = @company.id
    end
    @ioi = Ioi.new
    @ioi.name = @cip.deal.company.name + " / " + @company.name + " IOI"
    @ioi.deal_id = @cip.deal_id
    @ioi.ioi_date = Date.current
    @ioi.save

    @cip_company.ioi_id = @ioi.id

    if @cip_company.save
      redirect_to "/cips/#{ params[:cip_id] }/companies", :notice => "\"#{@company_name}\" added to \"#{@cip.name}\" successfully."
    else
      render 'new'
    end
  end

  def edit
    @cip_company = CipCompany.find(params[:id])
  end

  def update
    @cip_company = CipCompany.find(params[:id])

    @cip_company.cip_id = params[:cip_id]
    @cip_company.company_id = params[:company_id]
    @cip_company.ioi_id = params[:ioi_id]

    if @cip_company.save
      redirect_to "/cip_companies/#{@cip_company.id}/", :notice => "CIP Company updated successfully!"
    else
      render 'edit'
    end
  end

  def update_status

    respond_to do |format|
      format.js do
        render('update.js.erb')
      end
    end
  end

  def destroy
    @cip_company = CipCompany.find(params[:id])

    @cip_company.destroy

    redirect_to "/cip_companies/#{@cip_company.id}/", :notice => "CIP Company deleted."
  end
  
  def import
    CipCompany.import(params[:file])
    redirect_to "/models/", notice: "CIP Companies imported"
  end
end
