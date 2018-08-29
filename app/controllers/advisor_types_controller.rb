class AdvisorTypesController < ApplicationController

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
    @advisor_types = AdvisorType.all.order("name ASC")
    respond_to do |format|
      format.html
      format.csv {send_data @advisor_types.to_csv }
    end
  end

  def show
    @advisor_type = AdvisorType.find(params[:id])
  end

  def new
    @advisor_type = AdvisorType.new
  end

  def create
    @advisor_type = AdvisorType.new
    @advisor_type.deal_include = params[:deal_include]
    @advisor_type.mp_include = params[:mp_include]
    @advisor_type.nda_include = params[:nda_include]

    @advisor_type.name = params[:name]

    if @advisor_type.save
      redirect_to "/advisor_types", :notice => "Advisor Type created successfully."
    else
      render 'new'
    end
  end

  def edit
    @advisor_type = AdvisorType.find(params[:id])
  end

  def update
    @advisor_type = AdvisorType.find(params[:id])

    @advisor_type.name = params[:name]
    @advisor_type.deal_include = params[:deal_include]
    @advisor_type.mp_include = params[:mp_include]
    @advisor_type.nda_include = params[:nda_include]

    if @advisor_type.save
      redirect_to "/advisor_types/#{@advisor_type.id}/", :notice => "Advisor Type updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @advisor_type = AdvisorType.find(params[:id])

    @advisor_type.destroy

    redirect_to "/models", :notice => "Advisor Type deleted."
  end

  def import
    AdvisorType.import(params[:file])
    redirect_to "/models/", notice: "Advisor Types imported"
  end

end
