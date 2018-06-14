class NDASlidesController < ApplicationController

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
    @nda_slides = NdaSlide.all

    respond_to do |format|
      format.html
      format.csv {send_data @nda_slides.to_csv }
    end
  end


  def show
    @nda_slide = NdaSlide.find(params[:id])
  end

  def new
    @nda_slide = NdaSlide.new
  end

  def create
    @nda_slide = NdaSlide.new


    @nda_slide.slide_id = params[:slide_id]
    @nda_slide.nda_id = params[:nda_id]
    @nda_slide.ppt_address = params[:ppt_address]

    if @nda_slide.save
      redirect_to "/ndas", :notice => "NDA Slide created successfully."
    else
      render 'new'
    end
  end

  def edit
    @nda_slide = NdaSlide.find(params[:id])
  end

  def update
    @nda_slide = NdaSlide.find(params[:id])

    @nda_slide.slide_id = params[:slide_id]
    @nda_slide.nda_id = params[:nda_id]
    @nda_slide.ppt_address = params[:ppt_address]

    if @nda_slide.save
      redirect_to "/nda_slides/#{@nda_slide.id}/", :notice => "NDA Slide updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @nda_slide = NdaSlide.find(params[:id])

    @nda_slide.destroy

    redirect_to "/ndas", :notice => "NDA Slide deleted."
  end
  
  def import
    NdaSlide.import(params[:file])
    redirect_to "/models/", notice: "NDA Slides imported"
  end
end
