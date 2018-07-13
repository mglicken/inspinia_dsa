class NdaHighlightsController < ApplicationController

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
    @nda_highlights = NdaHighlight.all

    respond_to do |format|
      format.html
      format.csv {send_data @nda_highlights.to_csv }
    end
  end

  def show
    @nda_highlights = NdaHighlight.all
    @nda_highlight = NdaHighlight.find(params[:id])
  end

  def new
    @nda_highlight = NdaHighlight.new
  end

  def create
    @nda_highlight = NdaHighlight.new
    @nda_highlight.nda_id = params[:nda_id]
    @nda_highlight.highlight_id = params[:highlight_id]
    if params[:detail].nil?
      @nda_highlight.detail = "N/A"
    else
      @nda_highlight.detail = params[:detail]
    end 
     
    respond_to do |format|
      format.html do
        if @nda_highlight.save
          redirect_to "/teasers/#{ params[:nda_id] }/companies", :notice => "#{@nda_highlight.highlight.name} Highlight added successfully."
        else
          render 'new'
        end
      end
        
      format.js do
        @nda_highlight.save
        render('create.js.erb')
      end
    end
  end

  def checkbox
    @status = params[:status].to_i
    @highlight = Highlight.find(params[:highlight_id])
    @teaser = Teaser.find(params[:teaser_id])
    @type = params[:type_id].to_i
    if @status == 1
      @ndas = Nda.where(id: (TeaserCompany.where(teaser_id: @teaser.id).pluck(:nda_id) + TeaserSponsor.where(teaser_id: @teaser.id).pluck(:nda_id)))
      @ndas.order("name ASC").each do |nda|
        nda_highlight = NdaHighlight.new
        nda_highlight.highlight_id = @highlight.id
        nda_highlight.nda_id = nda.id
        nda_highlight.detail = "N/A"
        nda_highlight.save
      end  
      if @type == 1
        redirect_to "/teasers/#{ @teaser.id }/companies", :notice => "#{@highlight.name} added successfully."
      else
        redirect_to "/teasers/#{ @teaser.id }/sponsors", :notice => "#{@highlight.name} added successfully."
      end
    else
      @nda_highlights = NdaHighlight.where(nda_id: (TeaserCompany.where(teaser_id: @teaser.id).pluck(:nda_id) + TeaserSponsor.where(teaser_id: @teaser.id).pluck(:nda_id)),highlight_id: @highlight.id)
      @nda_highlights.each do |nda_highlight|
        nda_highlight.destroy
      end  
      if @type == 1
        redirect_to "/teasers/#{ @teaser.id }/companies", :notice => "#{@highlight.name} removed."
      else
        redirect_to "/teasers/#{ @teaser.id }/sponsors", :notice => "#{@highlight.name} removed."
      end
    end 
  end

  def edit
    @nda_highlight = NdaHighlight.find(params[:id])
  end

  def update
    @nda_highlight = NdaHighlight.find(params[:id])

    @nda_highlight.nda_id = params[:nda_id]
    @nda_highlight.highlight_id = params[:highlight_id]
    if params[:detail].nil?
      @nda_highlight.detail = "N/A"
    else
      @nda_highlight.detail = params[:detail]
    end 
   

    if @nda_highlight.save
      redirect_to "/nda_highlights/#{nda_highlight.id}/", :notice => "NDA Highlight updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @nda_highlight = NdaHighlight.find(params[:id]) 
    
    @nda_highlight.destroy

    respond_to do |format|
      format.html do
        redirect_to "/nda_highlights/", :notice => "NDA Highlight deleted."
      end
      format.js do
        render('destroy.js.erb')
      end
    end
  end

  def import
    NdaHighlight.import(params[:file])
    redirect_to "/models/", notice: "NDA Highlights imported."
  end
end
