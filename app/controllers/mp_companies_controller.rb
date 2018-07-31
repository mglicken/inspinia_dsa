class MpCompaniesController < ApplicationController

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
    @mp_companies = MpCompany.all

    respond_to do |format|
      format.html
      format.csv {send_data @mp_companies.to_csv }
    end
  end


  def show
    @mp_company = MpCompany.find(params[:id])
  end

  def new
    @mp_company = MpCompany.new
  end

  def create
    @mp_company = MpCompany.new

    @mp_company.mp_id = params[:mp_id]
    @mp_company.company_id = params[:company_id]
    @mp_company.mp_date = params[:mp_date]
    @loi = Loi.new
    @loi.name = @mp_company.mp.deal.company.name + " / " + @mp_company.company.name + " LOI"
    @loi.deal_id = @mp_company.mp.deal_id
    @loi.loi_date = Date.current
    @loi.save
    @mp_company.loi_id = params[:loi_id]
    @mp_company.declined = params[:declined]
    @mp_company.final_buyer = params[:final_buyer]

    #Create LoiHighlights for each Highlight associated with other LOIs
    if LoiHighlight.where(loi_id: (@mp_company.mp.mp_sponsors.pluck(:loi_id) + @mp_company.mp.mp_companies.pluck(:loi_id)).uniq).present?
      Highlight.where(id: LoiHighlight.where(loi_id: (@mp_company.mp.mp_sponsors.pluck(:loi_id) + @mp_company.mp.mp_companies.pluck(:loi_id)).uniq).pluck(:highlight_id).uniq).each do |highlight|
        loi_highlight = LoiHighlight.new
        loi_highlight.loi_id = @loi.id
        loi_highlight.highlight_id = highlight.id
        loi_highlight.detail = "N/A"
        loi_highlight.save
      end
    end

    if @mp_company.save
      redirect_to "/mps/#{@mp_company.mp_id}/acquirers", :notice => "MP Company created successfully."
    else
      render 'new'
    end
  end

  def create_by_name
    @mp = Mp.find(params[:mp_id])
    @company_name = params[:name]
    @mp_company = MpCompany.new
    @mp_company.mp_id = @mp.id
    if Company.find_by(name: @company_name).present?
      @company = Company.find_by(name: @company_name)
      @mp_company.company_id = @company.id
    else
      @company = Company.new
      @company.name = @company_name
      @company.save
      @mp_company.company_id = @company.id
    end

    if @mp_company.save
      redirect_to "/mps/#{ params[:mp_id] }/acquirers", :notice => "\"#{@company_name}\" added to \"#{@mp.name}\" successfully."
    else
      render 'new'
    end
  end

  def edit
    @mp_company = MpCompany.find(params[:id])
  end

  def update
    @mp_company = MpCompany.find(params[:id])

    @mp_company.mp_id = params[:mp_id]
    @mp_company.company_id = params[:company_id]
    @mp_company.mp_date = params[:mp_date]
    @mp_company.loi_id = params[:loi_id]
    @mp_company.declined = params[:declined]
    @mp_company.final_buyer = params[:final_buyer]

    if @mp_company.save
      redirect_to "/mp_companies/#{@mp_company.id}/", :notice => "MP Company updated successfully!"
    else
      render 'edit'
    end
  end

  def update_status
    @mp_company = MpCompany.find(params[:id])
    @company = @mp_company.company
    @mp = @mp_company.mp
    @status = params[:status].to_i

    if @status == 1
      if @mp_company.loi.present?
        @loi = @mp_company.loi
        @loi.destroy
        @mp_company.loi_id = nil
        @mp_company.declined = true
      else
        @loi=nil
        if @mp_company.declined == true  
          @mp_company.declined = false        
        else
          @mp_company.declined = true
        end
      end
    else
      @loi = Loi.new
      @loi.name = @mp.deal.company.name + " / " + @company.name + " LOI"
      @loi_date = Date.current
      @loi.deal_id = @mp.deal_id
      @loi.save
      @mp_company.loi_id = @loi.id
      @mp_company.declined = false
      #Create LoiHighlights for each Highlight associated with other LOIs
      if LoiHighlight.where(loi_id: (@mp_company.mp.mp_sponsors.pluck(:loi_id) + @mp_company.mp.mp_companies.pluck(:loi_id)).uniq).present?
        Highlight.where(id: LoiHighlight.where(loi_id: (@mp_company.mp.mp_sponsors.pluck(:loi_id) + @mp_company.mp.mp_companies.pluck(:loi_id)).uniq).pluck(:highlight_id).uniq).each do |highlight|
          loi_highlight = LoiHighlight.new
          loi_highlight.loi_id = @loi.id
          loi_highlight.highlight_id = highlight.id
          loi_highlight.save
        end
      end
    end

    if @mp_company.save
      respond_to do |format|
        format.js do
          render('update.js.erb')
        end
      end
    else
    redirect_to "/mps/<%= @mp.id%>/companies", notice: "Error"
    end
  end

  def destroy
    @mp_company = MpCompany.find(params[:id])

    @mp_company.destroy

    redirect_to "/mps/#{@mp_company.mp_id}/companies", :notice => "MP Company deleted."
  end
  
  def import
    MpCompany.import(params[:file])
    redirect_to "/models/", notice: "MP Companies imported"
  end
end
