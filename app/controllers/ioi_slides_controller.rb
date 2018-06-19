class IoiSlidesController < ApplicationController

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
    @ioi_slides = IoiSlide.all

    respond_to do |format|
      format.html
      format.csv {send_data @ioi_slides.to_csv }
    end
  end


  def show
    @ioi_slide = IoiSlide.find(params[:id])
  end

  def new
    @ioi_slide = IoiSlide.new
  end

  def create
    @ioi_slide = IoiSlide.new

    @ioi_slide.slide_id = params[:slide_id]
    @ioi_slide.ioi_id = params[:ioi_id]
    @ioi_slide.ppt_address = params[:ppt_address]

    if @ioi_slide.save
      redirect_to "/ndas/#{@ioi_slide.ioi_id}", :notice => "IOI Slide created successfully."
    else
      render 'new'
    end
  end

  def edit
    @ioi_slide = IoiSlide.find(params[:id])
  end

  def update
    @ioi_slide = IoiSlide.find(params[:id])

    @ioi_slide.slide_id = params[:slide_id]
    @ioi_slide.ioi_id = params[:ioi_id]
    @ioi_slide.ppt_address = params[:ppt_address]

    if @ioi_slide.save
      redirect_to "/iois/#{@ioi_slide.ioi_id}", :notice => "IOI Slide updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @ioi_slide = IoiSlide.find(params[:id])

    @ioi_slide.destroy

    redirect_to "/iois/#{@ioi_slide.ioi_id}", :notice => "IOI Slide deleted."
  end
  
  def import
    IoiSlide.import(params[:file])
    redirect_to "/models/", notice: "IOI Slides imported"
  end
end
