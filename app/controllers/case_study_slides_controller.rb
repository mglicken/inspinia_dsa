class CaseStudySlidesController < ApplicationController

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
    @case_study_slides = CaseStudySlide.all

    respond_to do |format|
      format.html
      format.csv {send_data @case_study_slides.to_csv }
    end
  end

  def show
    @case_study_slide = CaseStudySlide.find(params[:id])
  end

  def new
    @case_study_slide = CaseStudySlide.new
  end

  def create
    @case_study_slide = CaseStudySlide.new


    @case_study_slide.slide_id = params[:slide_id]
    @case_study_slide.case_study_id = params[:case_study_id]
    @case_study_slide.ppt_address = params[:ppt_address]

    if @case_study_slide.save
      redirect_to "/case_studies", :notice => "Case Study Slide created successfully."
    else
      render 'new'
    end
  end

  def edit
    @case_study_slide = CaseStudySlide.find(params[:id])
  end

  def update
    @case_study_slide = CaseStudySlide.find(params[:id])

    @case_study_slide.slide_id = params[:slide_id]
    @case_study_slide.case_study_id = params[:case_study_id]
    @case_study_slide.ppt_address = params[:ppt_address]

    if @case_study_slide.save
      redirect_to "/case_study_slides/#{@case_study_slide.id}/", :notice => "Case Study Slide updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @case_study_slide = CaseStudySlide.find(params[:id])

    @case_study_slide.destroy

    redirect_to "/case_studies", :notice => "Case Study Slide deleted."
  end

  def import
    CaseStudySlide.import(params[:file])
    redirect_to "/models/", notice: "Case Study Slides imported"
  end
end
