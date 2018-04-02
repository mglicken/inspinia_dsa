class TeaserSlidesController < ApplicationController

#before_action :ensure_access

  def ensure_access
    if current_user.access_id.present?
      if current_user.access_id > 3
        redirect_to root_url, :alert => "Not Authorized"
      end
    end
  end

  def index
    @teaser_slides = TeaserSlide.all

    respond_to do |format|
      format.html
      format.csv {send_data @teaser_slides.to_csv }
    end
  end

  def show
    @teaser_slide = TeaserSlide.find(params[:id])
  end

  def new
    @teaser_slide = TeaserSlide.new
  end

  def create
    @teaser_slide = TeaserSlide.new


    @teaser_slide.slide_id = params[:slide_id]
    @teaser_slide.teaser_id = params[:teaser_id]


    if @teaser_slide.save
      redirect_to "/teasers", :notice => "Teaser Slide created successfully."
    else
      render 'new'
    end
  end

  def edit
    @teaser_slide = TeaserSlide.find(params[:id])
  end

  def update
    @teaser_slide = TeaserSlide.find(params[:id])

    @teaser_slide.slide_id = params[:slide_id]
    @teaser_slide.teaser_id = params[:teaser_id]


    if @teaser_slide.save
      redirect_to "/teaser_slides/#{@teaser_slide.id}/", :notice => "Teaser Slide updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @teaser_slide = TeaserSlide.find(params[:id])

    @teaser_slide.destroy

    redirect_to "/teasers", :notice => "Teaser Slide deleted."
  end

  def import
    TeaserSlide.import(params[:file])
    redirect_to "/models/", notice: "Teaser Slides imported."
  end
end
