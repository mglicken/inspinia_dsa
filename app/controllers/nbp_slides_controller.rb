class NbpSlidesController < ApplicationController

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
    @nbp_slides = NbpSlide.all

    respond_to do |format|
      format.html
      format.csv {send_data @nbp_slides.to_csv }
    end
  end

  def show
    @nbp_slide = NbpSlide.find(params[:id])
  end

  def new
    @nbp_slide = NbpSlide.new
  end

  def create
    @nbp_slide = NbpSlide.new


    @nbp_slide.slide_id = params[:slide_id]
    @nbp_slide.nbp_id = params[:nbp_id]
    @nbp_slide.ppt_address = params[:ppt_address]

    if @nbp_slide.save
      redirect_to "/nbps", :notice => "NBP Slide created successfully."
    else
      render 'new'
    end
  end

  def edit
    @nbp_slide = NbpSlide.find(params[:id])
  end

  def update
    @nbp_slide = NbpSlide.find(params[:id])

    @nbp_slide.slide_id = params[:slide_id]
    @nbp_slide.nbp_id = params[:nbp_id]
    @nbp_slide.ppt_address = params[:ppt_address]

    if @nbp_slide.save
      redirect_to "/nbp_slides/#{@nbp_slide.id}/", :notice => "NBP slide updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @nbp_slide = NbpSlide.find(params[:id])

    @nbp_slide.destroy

    redirect_to "/nbps", :notice => "NBP slide deleted."
  end

  def import
    NbpSlide.import(params[:file])
    redirect_to "/models/", notice: "NBP Slides imported."
  end
end
