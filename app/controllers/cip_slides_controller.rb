class CipSlidesController < ApplicationController
  def index
    @cip_slides = CipSlide.all

    respond_to do |format|
      format.html
      format.csv {send_data @cip_slides.to_csv }
    end
  end

  def rand_string
    
    alpha = "abcdefghijklmnopqrstuvwxyz"

    for i in 1..20
      if i==1
        x ="x"
        y ="x"
      end
        x ="x"
        y = x + "x"
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
