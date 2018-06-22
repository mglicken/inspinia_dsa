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
    @cip_company.declined = params[:declined]

    if @cip_company.save
      redirect_to "/cips/#{@cip_company.cip_id}", :notice => "CIP Company created successfully."
    else
      render 'new'
    end
  end

  def create_by_name
    @cip = Cip.find(params[:cip_id])
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
    @cip_company.declined = params[:declined]

    if @cip_company.save
      redirect_to "/cip_companies/#{@cip_company.id}/", :notice => "CIP Company updated successfully!"
    else
      render 'edit'
    end
  end

  def update_status
    @cip_company = CipCompany.find(params[:id])
    @company = @cip_company.company
    @cip = @cip_company.cip
    @status = params[:status].to_i
    

    if @status == 1
      if @cip_company.ioi.present?
        @ioi = @cip_company.ioi
        @ioi.destroy
        @cip_company.declined = true
      else
        @ioi=nil
        @cip_company.declined = false
      end
    else
      @ioi = Ioi.new
      @ioi.name = @@company.name + " IOI"
      @ioi_date = Date.current
      @ioi.deal_id = @cip.deal_id
      @ioi.save
      @cip_company.ioi_id = @ioi.id
      @cip_company.declined = false
      #Create IoiHighlights for each Highlight associated with other IOIs
      if IoiHighlight.where(ioi_id: (@cip_company.cip.cip_sponsors.pluck(:ioi_id) + @cip_company.cip.cip_companies.pluck(:ioi_id)).uniq).present?
        Highlight.where(id: IoiHighlight.where(ioi_id: (@cip_company.cip.cip_sponsors.pluck(:ioi_id) + @cip_company.cip.cip_companies.pluck(:ioi_id)).uniq).pluck(:highlight_id).uniq).each do |highlight|
          ioi_highlight = IoiHighlight.new
          ioi_highlight.ioi_id = @ioi.id
          ioi_highlight.highlight_id = highlight.id
          ioi_highlight.save
        end
      end
    end

    if @cip_company.save
      respond_to do |format|
        format.js do
          render('update.js.erb')
        end
      end
    else
    redirect_to "/cips/<%= @cip.id%>/companies", notice: "Error"
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
