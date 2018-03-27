class SlideTagsController < ApplicationController
  def index
    @slide_tags = SlideTag.all

    respond_to do |format|
      format.html
      format.csv {send_data @slide_tags.to_csv }
    end
  end

  def show
    @slide_tags = SlideTag.all
    @slide_tag = SlideTag.find(params[:id])
  end

  def new
    @slide_tag = SlideTag.new
  end

  def create
    @slide_tag = SlideTag.new
    @slide_tag.slide_id = params[:slide_id]
    @slide_tag.tag_id = params[:tag_id]
 
    respond_to do |format|
      format.html do
        if @slide_tag.save
          redirect_to "/slides/#{ params[:slide_id] }", :notice => "Slide Tag added successfully."
        else
          render 'new'
        end
      end
        
      format.js do
        @slide_tag.save
        render('create.js.erb')
      end
    end
  end

  def edit
    @slide_tag = SlideTag.find(params[:id])
  end

  def update
    @slide_tag = SlideTag.find(params[:id])

    @slide_tag.slide_id = params[:slide_id]
    @slide_tag.tag_id = params[:tag_id]


    if @slide_tag.save
      redirect_to "/slide_tags/#{slide_tag.id}/", :notice => "Slide Tag updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @slide_tag = SlideTag.find(params[:id])
    @slide_tag.destroy

    respond_to do |format|
      format.html do
        redirect_to "/slide_tags/", :notice => "Slide Tag deleted."
      end
      format.js do
        render('destroy.js.erb')
      end
    end
  end

  def import
    SlideTag.import(params[:file])
    redirect_to "/models/", notice: "Slide Tags imported."
  end
end
