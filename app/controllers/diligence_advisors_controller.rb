class DiligenceAdvisorsController < ApplicationController

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
    @diligence_advisors = DiligenceAdvisor.all

    respond_to do |format|
      format.html
      format.csv {send_data @diligence_advisors.to_csv }
    end
  end

  def show
    @diligence_advisors = DiligenceAdvisor.all
    @diligence_advisor = DiligenceAdvisor.find(params[:id])
  end

  def new
    @diligence_advisor = DiligenceAdvisor.new
  end

  def create
    @diligence_advisor = DiligenceAdvisor.new
    @diligence_advisor.person_id = params[:person_id]
    @diligence_advisor.company_id = params[:company_id]
    @diligence_advisor.advisor_type_id = params[:advisor_type_id]
    @diligence_advisor.deal_id = params[:deal_id]
    @diligence_advisor.nda_id = params[:nda_id]
    @diligence_advisor.mp_company_id = params[:mp_company_id]
    @diligence_advisor.mp_sponsor_id = params[:mp_sponsor_id]
     
    respond_to do |format|
      format.html do
        if @diligence_advisor.save
          if @diligence_advisor.deal.present?
            if @diligence_advisor.advisor_type.name == "Quality of Earnings Advisor"
              redirect_to "/qoves/#{ @diligence_advisor.deal.qoves.last.id}/", :notice => "#{@diligence_advisor.advisor_type.name} Advisor Type added successfully."
            elsif @diligence_advisor.advisor_type.name == "Market Study Advisor"
              redirect_to "/market_studies/#{ @diligence_advisor.deal.market_studies.last.id}", :notice => "#{@diligence_advisor.advisor_type.name} Advisor Type added successfully."
            end
          elsif @diligence_advisor.nda.present?
            redirect_to "/ndas/#{ @diligence_advisor.nda_id}", :notice => "#{@diligence_advisor.advisor_type.name} Advisor Type added successfully."
          elsif @diligence_advisor.nda.present?
            redirect_to "/lois/#{ @diligence_advisor.mp_company.loi_id}", :notice => "#{@diligence_advisor.advisor_type.name} Advisor Type added successfully."
          elsif @diligence_advisor.mp_sponsor.present?
            redirect_to "/lois/#{ @diligence_advisor.mp_sponsor.loi_id}", :notice => "#{@diligence_advisor.advisor_type.name} Advisor Type added successfully."
          end             
        else
          render 'new'
        end
      end
        
      format.js do
        @diligence_advisor.save
        render('create.js.erb')
      end
    end
  end


  def edit
    @diligence_advisor = DiligenceAdvisor.find(params[:id])
  end

  def update
    @diligence_advisor = DiligenceAdvisor.find(params[:id])

    @diligence_advisor.person_id = params[:person_id]
    @diligence_advisor.company_id = params[:company_id]
    @diligence_advisor.advisor_type_id = params[:advisor_type_id]
    @diligence_advisor.deal_id = params[:deal_id]
    @diligence_advisor.nda_id = params[:nda_id]
    @diligence_advisor.mp_company_id = params[:mp_company_id]
    @diligence_advisor.mp_sponsor_id = params[:mp_sponsor_id]

    respond_to do |format|
      format.html do
        if @diligence_advisor.save
          if @diligence_advisor.deal.present?
            redirect_to "/deals/#{ @diligence_advisor.deal_id}", :notice => "#{@diligence_advisor.advisor_type.name} Advisor Type added successfully."
          elsif @diligence_advisor.nda.present?
            redirect_to "/ndas/#{ @diligence_advisor.nda_id}", :notice => "#{@diligence_advisor.advisor_type.name} Advisor Type added successfully."
          elsif @diligence_advisor.nda.present?
            redirect_to "/lois/#{ @diligence_advisor.mp_company.loi_id}", :notice => "#{@diligence_advisor.advisor_type.name} Advisor Type added successfully."
          elsif @diligence_advisor.mp_sponsor.present?
            redirect_to "/lois/#{ @diligence_advisor.mp_sponsor.loi_id}", :notice => "#{@diligence_advisor.advisor_type.name} Advisor Type added successfully."
          end 
        else
          render 'new'
        end
      end
    end
  end

  def destroy
    @diligence_advisor = DiligenceAdvisor.find(params[:id]) 
    
    @diligence_advisor.destroy

    respond_to do |format|
      format.html do
        redirect_to "/diligence_advisors/", :notice => "IOI Advisor Type deleted."
      end
      format.js do
        render('destroy.js.erb')
      end
    end
  end

  def import
    DiligenceAdvisor.import(params[:file])
    redirect_to "/models/", notice: "IOI Advisor Types imported."
  end
end
