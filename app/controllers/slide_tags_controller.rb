class SlideTagsController < ApplicationController

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

  def create_by_name
    @slide = Slide.find(params[:slide_id])
    @tag_name = params[:name]
    @slide_tag = SlideTag.new
    @slide_tag.slide_id = @slide.id

    if Tag.find_by(name: @tag_name).present?
      @tag = Tag.find_by(name: @tag_name)
      @slide_tag.tag_id = @tag.id
    else
      @tag = Tag.new
      @tag.name = @tag_name
      @tag.save
      @slide_tag.tag_id = @tag.id
    end

    if @slide_tag.save
      redirect_to "/slides/#{ params[:slide_id] }", :notice => "\"#{@tag_name}\" Tag added successfully."
    else
      render 'new'
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
