class CipSlidesController < ApplicationController

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
    @cip_slides = CipSlide.all

    respond_to do |format|
      format.html
      format.csv {send_data @cip_slides.to_csv }
    end
  end


  def show
    @cip_slide = CipSlide.find(params[:id])
  end

  def new
    @cip_slide = CipSlide.new
  end

  def create
    @cip_slide = CipSlide.new


    @cip_slide.slide_id = params[:slide_id]
    @cip_slide.cip_id = params[:cip_id]
    @cip_slide.ppt_address = params[:ppt_address]

    if @cip_slide.save
      redirect_to "/cips", :notice => "CIP Slide created successfully."
    else
      render 'new'
    end
  end

  def edit
    @cip_slide = CipSlide.find(params[:id])
  end

  def update
    @cip_slide = CipSlide.find(params[:id])

    @cip_slide.slide_id = params[:slide_id]
    @cip_slide.cip_id = params[:cip_id]
    @cip_slide.ppt_address = params[:ppt_address]

    if @cip_slide.save
      redirect_to "/cip_slides/#{@cip_slide.id}/", :notice => "CIP slide updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @cip_slide = CipSlide.find(params[:id])

    @cip_slide.destroy

    redirect_to "/cips", :notice => "CIP slide deleted."
  end
  
  def import
    CipSlide.import(params[:file])
    redirect_to "/models/", notice: "CIP Slides imported"
  end
end
