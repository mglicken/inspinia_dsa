class NbpTagsController < ApplicationController

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
    @nbp_tags = NbpTag.all

    respond_to do |format|
      format.html
      format.csv {send_data @nbp_tags.to_csv }
    end
  end

  def show
    @nbp_tags = NbpTag.all
    @nbp_tag = NbpTag.find(params[:id])
  end

  def new
    @nbp_tag = NbpTag.new
  end

  def create
    @nbp_tag = NbpTag.new
    @nbp_tag.nbp_id = params[:nbp_id]
    @nbp_tag.tag_id = params[:tag_id]
     
    respond_to do |format|
      format.html do
        if @nbp_tag.save
          redirect_to "/nbps/#{ params[:nbp_id] }/companies", :notice => "#{@nbp_tag.tag.name} Tag added successfully."
        else
          render 'new'
        end
      end
        
      format.js do
        @nbp_tag.save
        render('create.js.erb')
      end
    end
  end

  def create_by_name
    @nbp = Nbp.find(params[:nbp_id])
    @tag_name = params[:name]
    @nbp_tag = NbpTag.new
    @nbp_tag.nbp_id = @nbp.id

    if Tag.find_by(name: @tag_name).present?
      @tag = Tag.find_by(name: @tag_name)
      @nbp_tag.tag_id = @tag.id
    else
      @tag = Tag.new
      @tag.name = @tag_name
      @tag.save
      @nbp_tag.tag_id = @tag.id
    end

    if @nbp_tag.save
      @nbp.nbp_companies.each do |nbp_company|
        strip_tag = StripTag.new
        strip_tag.tag_id = @tag.id
        strip_tag.nbp_company_id = nbp_company.id
        strip_tag.save
      end
      redirect_to "/nbps/#{ params[:nbp_id] }/companies", :notice => "\"#{@tag_name}\" Tag added successfully."
    else
      render 'new'
    end

  end

  def edit
    @nbp_tag = NbpTag.find(params[:id])
  end

  def update
    @nbp_tag = NbpTag.find(params[:id])

    @nbp_tag.nbp_id = params[:nbp_id]
    @nbp_tag.tag_id = params[:tag_id]
    

    if @nbp_tag.save
      redirect_to "/nbp_tags/#{nbp_tag.id}/", :notice => "NBP Tag updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @nbp_tag = NbpTag.find(params[:id])
    StripTag.where(nbp_company_id: @nbp_tag.nbp.nbp_companies.ids, tag_id: @nbp_tag.tag_id).each do |strip_tag|
      strip_tag.destroy
    end

    @nbp_tag.destroy

    respond_to do |format|
      format.html do
        redirect_to "/nbp_tags/", :notice => "NBP Tag deleted."
      end
      format.js do
        render('destroy.js.erb')
      end
    end
  end

  def import
    NbpTag.import(params[:file])
    redirect_to "/models/", notice: "NBP Tags imported."
  end
end
