class FavoriteSlidesController < ApplicationController

before_action :ensure_access

  def ensure_access
    if current_user.access_id.present?
      if current_user.access_id <= 3
        redirect_to root_url, :alert => "Not Authorized"
      end
    end
  end

  def index
    @favorite_slides = current_user.favorite_slides

    respond_to do |format|
      format.html
      format.csv {send_data FavoriteSlide.all.to_csv }
    end
  end

  def show
    @favorite_slides = FavoriteSlide.all
    @favorite_slide = FavoriteSlide.find(params[:id])
  end

  def new
    @favorite_slide = FavoriteSlide.new
  end

  def create
    @favorite_slide = FavoriteSlide.new
    @favorite_slide.slide_id = params[:slide_id]
    @favorite_slide.user_id = params[:user_id]
 
    respond_to do |format|
      format.html do
        if @favorite_slide.save
          redirect_to "/slides/#{ params[:slide_id] }", :notice => "Slide Favorited successfully!"
        else
          render 'new'
        end
      end
        
      format.js do
        @favorite_slide.save
        render('create.js.erb')
      end
    end
  end

  def edit
    @favorite_slide = FavoriteSlide.find(params[:id])
  end

  def update
    @favorite_slide = FavoriteSlide.find(params[:id])

    @favorite_slide.slide_id = params[:slide_id]
    @favorite_slide.user_id = params[:user_id]


    if @favorite_slide.save
      redirect_to "/favorite_slides/#{@favorite_slide.id}/", :notice => "Slide Favorite updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @favorite_slide = FavoriteSlide.find(params[:id])
    @favorite_slide.destroy

    respond_to do |format|
      format.html do
        redirect_to "/favorite_slides/", :notice => "Slide Unfavorited."
      end
      format.js do
        render('destroy.js.erb')
      end
    end
  end

  def import
    FavoriteSlide.import(params[:file])
    redirect_to "/models/", notice: "Favorite Slides imported"
  end
end
