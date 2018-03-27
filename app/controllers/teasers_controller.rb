class TeasersController < ApplicationController
  def index
    @teasers = Teaser.all

    respond_to do |format|
      format.html
      format.csv {send_data @teasers.to_csv }
    end
  end

  def show
    @teaser = Teaser.find(params[:id])
    @p_id = "teaser_#{@teaser.id}"
    @url = "/create_teaser_slide/#{params[:id]}"
  end

  def new
    @teaser = Teaser.new
  end

  def create
    @teaser = Teaser.new


    @teaser.deal_id = params[:deal_id]
    @teaser.teaser_date = params[:teaser_date]
    @teaser.image_id = params[:image_id]


    if @teaser.save
      redirect_to "/teasers", :notice => "Teaser created successfully."
    else
      render 'new'
    end
  end

  def copy_layout
    @teaser = Teaser.find(params[:teaser_id])
    @slide_layout = SlideLayout.new

    @slide_layout.name = @teaser.name
    @slide_layout.date = Date.today
    @slide_layout.user_id = current_user.id
    @slide_layout.deal_id = @teaser.deal_id

    if @slide_layout.save
      @teaser.slides.each do |slide|
        sls = SlideLayoutSlide.new
        sls.slide_id = slide.id
        sls.slide_layout_id = @slide_layout.id
        sls.save
      end
      redirect_to "/slide_layouts/#{@slide_layout.id}", :notice => "Teaser Layout copied successfully."
    else
      render 'new'
    end
  end

  def edit
    @teaser = Teaser.find(params[:id])
  end

  def update
    @teaser = Teaser.find(params[:id])

    @teaser.deal_id = params[:deal_id]
    @teaser.teaser_date = params[:teaser_date]
    @teaser.image_id = params[:image_id]

    if @teaser.save
      redirect_to "/teasers", :notice => "Teaser updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @teaser = Teaser.find(params[:id])

    @teaser.destroy

    redirect_to "/teasers", :notice => "Teaser deleted."
  end

  def import
    Teaser.import(params[:file])
    redirect_to "/models/", notice: "Teasers imported."
  end
end
