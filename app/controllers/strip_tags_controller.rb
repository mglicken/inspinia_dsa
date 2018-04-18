class StripTagsController < ApplicationController

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
    @strip_tags = StripTag.all

    respond_to do |format|
      format.html
      format.csv {send_data @strip_tags.to_csv }
    end
  end

  def show
    @strip_tags = StripTag.all
    @strip_tag = StripTag.find(params[:id])
  end

  def new
    @strip_tag = StripTag.new
  end

  def create
    @strip_tag = StripTag.new
    @strip_tag.nbp_company_id = params[:nbp_company_id]
    @strip_tag.tag_id = params[:tag_id]
    @strip_tag.value = params[:value]
 
    respond_to do |format|
      format.html do
        if @strip_tag.save
          redirect_to "/slides/#{ params[:nbp_company_id] }", :notice => "Strip Tag added successfully."
        else
          render 'new'
        end
      end
        
      format.js do
        @strip_tag.save
        render('create.js.erb')
      end
    end
  end

  def edit
    @strip_tag = StripTag.find(params[:id])
  end

  def update
    @strip_tag = StripTag.find(params[:id])

    @strip_tag.nbp_company_id = params[:nbp_company_id]
    @strip_tag.tag_id = params[:tag_id]
    @strip_tag.value = params[:value]


    if @strip_tag.save
      redirect_to "/strip_tags/#{strip_tag.id}/", :notice => "Strip Tag updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @strip_tag = StripTag.find(params[:id])
    @strip_tag.destroy

    respond_to do |format|
      format.html do
        redirect_to "/strip_tags/", :notice => "Strip Tag deleted."
      end
      format.js do
        render('destroy.js.erb')
      end
    end
  end

  def import
    StripTag.import(params[:file])
    redirect_to "/models/", notice: "Strip Tags imported."
  end
end
