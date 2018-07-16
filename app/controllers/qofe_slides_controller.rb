class QofeSlidesController < ApplicationController

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
    @qofe_slides = QofeSlide.all

    respond_to do |format|
      format.html
      format.csv {send_data @qofe_slides.to_csv }
    end
  end

  def show
    @qofe_slide = QofeSlide.find(params[:id])
  end

  def new
    @qofe_slide = QofeSlide.new
  end

  def create
    @qofe_slide = QofeSlide.new


    @qofe_slide.slide_id = params[:slide_id]
    @qofe_slide.qofe_id = params[:qofe_id]

    if @qofe_slide.save
      redirect_to "/market_studies", :notice => "QofE Slide created successfully."
    else
      render 'new'
    end
  end

  def edit
    @qofe_slide = QofeSlide.find(params[:id])
  end

  def update
    @qofe_slide = QofeSlide.find(params[:id])

    @qofe_slide.slide_id = params[:slide_id]
    @qofe_slide.qofe_id = params[:qofe_id]

    if @qofe_slide.save
      redirect_to "/qofe_slides/#{@qofe_slide.id}/", :notice => "QofE Slide updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @qofe_slide = QofeSlide.find(params[:id])

    @qofe_slide.destroy

    redirect_to "/market_studies", :notice => "QofE Slide deleted."
  end

  def import
    QofeSlide.import(params[:file])
    redirect_to "/models/", notice: "QofE Slides imported"
  end
end
