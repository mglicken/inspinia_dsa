class DealTypesController < ApplicationController

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
    @deal_types = DealType.all.order("name ASC")
    respond_to do |format|
      format.html
      format.csv {send_data @deal_types.to_csv }
    end
  end

  def show
    @deal_type = DealType.find(params[:id])
  end

  def new
    @deal_type = DealType.new
  end

  def create
    @deal_type = DealType.new


    @deal_type.name = params[:name]

    if @deal_type.save
      redirect_to "/deal_types", :notice => "Deal Type created successfully."
    else
      render 'new'
    end
  end

  def edit
    @deal_type = DealType.find(params[:id])
  end

  def update
    @deal_type = DealType.find(params[:id])

    @deal_type.name = params[:name]

    if @deal_type.save
      redirect_to "/deal_types/#{@deal_type.id}/", :notice => "Deal Type updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @deal_type = DealType.find(params[:id])

    @deal_type.destroy

    redirect_to "/models", :notice => "Deal Type deleted."
  end

  def import
    DealType.import(params[:file])
    redirect_to "/models", notice: "Deal Types imported"
  end

end
