class NbpSlidesController < ApplicationController

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
    redirect_to "/nbp_slides/", notice: "NBP Slides imported."
  end
end
