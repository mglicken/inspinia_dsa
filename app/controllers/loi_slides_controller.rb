class LoiSlidesController < ApplicationController

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
    @loi_slides = LoiSlide.all

    respond_to do |format|
      format.html
      format.csv {send_data @loi_slides.to_csv }
    end
  end


  def show
    @loi_slide = LoiSlide.find(params[:id])
  end

  def new
    @loi_slide = LoiSlide.new
  end

  def create
    @loi_slide = LoiSlide.new

    @loi_slide.slide_id = params[:slide_id]
    @loi_slide.loi_id = params[:loi_id]
    @loi_slide.ppt_address = params[:ppt_address]

    if @loi_slide.save
      redirect_to "/ndas/#{@loi_slide.loi_id}", :notice => "IOI Slide created successfully."
    else
      render 'new'
    end
  end

  def edit
    @loi_slide = LoiSlide.find(params[:id])
  end

  def update
    @loi_slide = LoiSlide.find(params[:id])

    @loi_slide.slide_id = params[:slide_id]
    @loi_slide.loi_id = params[:loi_id]
    @loi_slide.ppt_address = params[:ppt_address]

    if @loi_slide.save
      redirect_to "/iois/#{@loi_slide.loi_id}", :notice => "IOI Slide updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @loi_slide = LoiSlide.find(params[:id])

    @loi_slide.destroy

    redirect_to "/iois/#{@loi_slide.loi_id}", :notice => "IOI Slide deleted."
  end
  
  def import
    LoiSlide.import(params[:file])
    redirect_to "/models/", notice: "IOI Slides imported"
  end
end
