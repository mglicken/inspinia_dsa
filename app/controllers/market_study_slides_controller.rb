class MarketStudySlidesController < ApplicationController

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
    @market_study_slides = MarketStudySlide.all

    respond_to do |format|
      format.html
      format.csv {send_data @market_study_slides.to_csv }
    end
  end

  def show
    @market_study_slide = MarketStudySlide.find(params[:id])
  end

  def new
    @market_study_slide = MarketStudySlide.new
  end

  def create
    @market_study_slide = MarketStudySlide.new


    @market_study_slide.slide_id = params[:slide_id]
    @market_study_slide.market_study_id = params[:market_study_id]

    if @market_study_slide.save
      redirect_to "/market_studies", :notice => "Market Study Slide created successfully."
    else
      render 'new'
    end
  end

  def edit
    @market_study_slide = MarketStudySlide.find(params[:id])
  end

  def update
    @market_study_slide = MarketStudySlide.find(params[:id])

    @market_study_slide.slide_id = params[:slide_id]
    @market_study_slide.market_study_id = params[:market_study_id]

    if @market_study_slide.save
      redirect_to "/market_study_slides/#{@market_study_slide.id}/", :notice => "Market Study Slide updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @market_study_slide = MarketStudySlide.find(params[:id])

    @market_study_slide.destroy

    redirect_to "/market_studies", :notice => "Market Study Slide deleted."
  end

  def import
    MarketStudySlide.import(params[:file])
    redirect_to "/models/", notice: "Market Study Slides imported"
  end
end
