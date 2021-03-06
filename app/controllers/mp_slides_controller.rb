class MpSlidesController < ApplicationController

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
    @mp_slides = MpSlide.all

    respond_to do |format|
      format.html
      format.csv {send_data @mp_slides.to_csv }
    end
  end

  def show
    @mp_slide = MpSlide.find(params[:id])
  end

  def new
    @mp_slide = MpSlide.new
  end

  def create
    @mp_slide = MpSlide.new


    @mp_slide.slide_id = params[:slide_id]
    @mp_slide.mp_id = params[:mp_id]
    @mp_slide.ppt_address = params[:ppt_address]

    if @mp_slide.save
      redirect_to "/mps", :notice => "MP Slide created successfully."
    else
      render 'new'
    end
  end
  
  def edit
    @mp_slide = MpSlide.find(params[:id])
  end

  def update
    @mp_slide = MpSlide.find(params[:id])

    @mp_slide.slide_id = params[:slide_id]
    @mp_slide.mp_id = params[:mp_id]
    @mp_slide.ppt_address = params[:ppt_address]

    if @mp_slide.save
      redirect_to "/mp_slides/#{@mp_slide.id}/", :notice => "MP slide updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @mp_slide = MpSlide.find(params[:id])

    @mp_slide.destroy

    redirect_to "/mps", :notice => "MP slide deleted."
  end

  def import
    MpSlide.import(params[:file])
    redirect_to "/models/", notice: "MP Slides imported"
  end
end
