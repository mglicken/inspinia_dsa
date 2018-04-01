class TagsController < ApplicationController

before_action :ensure_access

  def ensure_access
    if current_user.access_id.present?
      if current_user.access_id > 3
        redirect_to root_url, :alert => "Not Authorized"
      end
    end
  end

  def index
    @tags = Tag.all.order("name ASC")

    respond_to do |format|
      format.html
      format.csv {send_data @tags.to_csv }
    end
  end

  def search
    @text = params[:search].downcase
    tag_ids = []
    Tag.all.each do |tag|
      if tag.name.downcase.include? @text
        tag_ids.push(tag.id)
      end
    end
    @tags=Tag.where(id: tag_ids)
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new


    @tag.name = params[:name]

    if @tag.save
      redirect_to "/tags", :notice => "Tag created successfully."
    else
      render 'new'
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])

    @tag.name = params[:name]

    if @tag.save
      redirect_to "/tags/#{@tag.id}/", :notice => "Tag updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @tag = Tag.find(params[:id])

    @tag.destroy

    redirect_to "/Tags", :notice => "Tag deleted."
  end
  def import
    Tag.import(params[:file])
    redirect_to "/models/", notice: "Tags imported"
  end
end
