class CaseStudiesController < ApplicationController

before_action :ensure_banker_access,  only: [:new, :create, :copy_layout, :edit, :update, :destroy, :import]
before_action :ensure_view_access,  only: [:index, :search, :show]

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
    @case_studies = CaseStudy.all

    respond_to do |format|
      format.html
      format.csv {send_data @case_studies.to_csv }
    end
  end

  def show
    @case_study = CaseStudy.find(params[:id])
    @p_id = "case_study_#{@case_study.id}"
    @url = "/create_case_study_slide/#{params[:id]}"
  end

  def new
    @case_study = CaseStudy.new
  end

  def create
    @case_study = CaseStudy.new

    @case_study.name = params[:name]
    @case_study.deal_id = params[:deal_id]
    @case_study.image_id = params[:image_id]


    if @case_study.save
      redirect_to "/case_studies/#{@case_study.id}", :notice => "Case Study created successfully."
    else
      render 'new'
    end
  end

  def copy_layout
    @case_study = CaseStudy.find(params[:case_study_id])
    @slide_layout = SlideLayout.new

    @slide_layout.name = @case_study.name
    @slide_layout.date = Date.today
    @slide_layout.user_id = current_user.id
    @slide_layout.deal_id = @case_study.deal_id

    if @slide_layout.save
      @case_study.slides.each do |slide|
        sls = SlideLayoutSlide.new
        sls.slide_id = slide.id
        sls.slide_layout_id = @slide_layout.id
        sls.save
      end
      redirect_to "/slide_layouts/#{@slide_layout.id}", :notice => "Case Study Layout copied successfully."
    else
      render 'new'
    end
  end

  def edit
    @case_study = CaseStudy.find(params[:id])
  end

  def update
    @case_study = CaseStudy.find(params[:id])

    @case_study.name = params[:name]
    @case_study.deal_id = params[:deal_id]
    @case_study.image_id = params[:image_id]

    if @case_study.save
      redirect_to "/case_studies/#{@case_study.id}", :notice => "Case Study updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @case_study = CaseStudy.find(params[:id])

    @case_study.destroy

    redirect_to "/case_studies", :notice => "Case Study deleted."
  end

  def import
    CaseStudy.import(params[:file])
    redirect_to "/models/", notice: "Case Studies imported"
  end
end
