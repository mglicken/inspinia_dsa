class DealStageController < ApplicationController

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
    @deal_stages = DealStage.all.order("name ASC")
    respond_to do |format|
      format.html
      format.csv {send_data @deal_stages.to_csv }
    end
  end

  def show
    @deal_stage = DealStage.find(params[:id])
  end

  def new
    @deal_stage = DealStage.new
  end

  def create
    @deal_stage = DealStage.new


    @deal_stage.name = params[:name]

    if @deal_stage.save
      redirect_to "/deal_stages", :notice => "Deal Stage created successfully."
    else
      render 'new'
    end
  end

  def edit
    @deal_stage = DealStage.find(params[:id])
  end

  def update
    @deal_stage = DealStage.find(params[:id])

    @deal_stage.name = params[:name]

    if @deal_stage.save
      redirect_to "/deal_stages/#{@deal_stage.id}/", :notice => "Deal Stage updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @deal_stage = DealStage.find(params[:id])

    @deal_stage.destroy

    redirect_to "/models", :notice => "Deal Stage deleted."
  end

  def import
    DealStage.import(params[:file])
    redirect_to "/models/", notice: "Deal Stages imported"
  end

end
