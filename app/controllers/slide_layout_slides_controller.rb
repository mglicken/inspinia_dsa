class SlideLayoutSlidesController < ApplicationController

before_action :ensure_access

  def ensure_access
    if current_user.access_id.present?
      if current_user.access_id > 3
        redirect_to root_url, :alert => "Not Authorized"
      end
    end
  end
  
  def index
    @slide_layout_slides = SlideLayoutSlide.all

    respond_to do |format|
      format.html
      format.csv {send_data @slide_layout_slides.to_csv }
    end
  end

  def show
    @slide_layout_slide = SlideLayoutSlide.find(params[:id])
  end

  def new
    @slide_layout_slide = SlideLayoutSlide.new
  end

  def create
    @slide_layout_slide = SlideLayoutSlide.new


    @slide_layout_slide.slide_id = params[:slide_id]
    @slide_layout_slide.slide_layout_id = params[:slide_layout_id]


    respond_to do |format|
      format.html do
        if @slide_layout_slide.save
          redirect_to "/slide_layouts/#{ @slide_layout_slide.slide_layout_id}", :notice => "Slide Layout Slide added successfully."
        else
          render 'new'
        end
      end
        
      format.js do
        @slide_layout_slide.save
        render('create.js.erb')
      end
    end
  end

  def edit
    @slide_layout_slide = SlideLayoutSlide.find(params[:id])
  end

  def update
    @slide_layout_slide = SlideLayoutSlide.find(params[:id])

    @slide_layout_slide.slide_id = params[:slide_id]
    @slide_layout_slide.slide_layout_id = params[:slide_layout_id]


    if @slide_layout_slide.save
      redirect_to "/slide_layouts/#{@slide_layout_slide.slide_layout_id}/", :notice => "Slide layout slide updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @slide_layout_slide = SlideLayoutSlide.find(params[:id])

    @slide_layout_slide.destroy

    redirect_to "/slide_layouts/#{ @slide_layout_slide.slide_layout_id}", :notice => "Slide layout slide deleted."
  end

  def import
    SlideLayoutSlide.import(params[:file])
    redirect_to "/models/", notice: "Slide Layout Slides imported."
  end
end
