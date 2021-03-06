class IoiHighlightsController < ApplicationController

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
    @ioi_highlights = IoiHighlight.all

    respond_to do |format|
      format.html
      format.csv {send_data @ioi_highlights.to_csv }
    end
  end

  def show
    @ioi_highlights = IoiHighlight.all
    @ioi_highlight = IoiHighlight.find(params[:id])
  end

  def new
    @ioi_highlight = IoiHighlight.new
  end

  def create
    @ioi_highlight = IoiHighlight.new
    @ioi_highlight.ioi_id = params[:ioi_id]
    @ioi_highlight.highlight_id = params[:highlight_id]
    if params[:detail].nil?
      @ioi_highlight.detail = "N/A"
    else
      @ioi_highlight.detail = params[:detail]
    end 
     
    respond_to do |format|
      format.html do
        if @ioi_highlight.save
          redirect_to "/cips/#{ params[:ioi_id] }/companies", :notice => "#{@ioi_highlight.highlight.name} Highlight added successfully."
        else
          render 'new'
        end
      end
        
      format.js do
        @ioi_highlight.save
        render('create.js.erb')
      end
    end
  end

  def checkbox
    @status = params[:status].to_i
    @highlight = Highlight.find(params[:highlight_id])
    @cip = Cip.find(params[:cip_id])
    @type = params[:type_id].to_i
    if @status == 1
      @iois = Ioi.where(id: (CipCompany.where(cip_id: @cip.id).pluck(:ioi_id) + CipSponsor.where(cip_id: @cip.id).pluck(:ioi_id)))
      @iois.order("name ASC").each do |ioi|
        ioi_highlight = IoiHighlight.new
        ioi_highlight.highlight_id = @highlight.id
        ioi_highlight.ioi_id = ioi.id
        ioi_highlight.detail = "N/A"
        ioi_highlight.save
      end  
      if @type == 1
        redirect_to "/cips/#{ @cip.id }/companies", :notice => "#{@highlight.name} added successfully."
      else
        redirect_to "/cips/#{ @cip.id }/sponsors", :notice => "#{@highlight.name} added successfully."
      end
    else
      @ioi_highlights = IoiHighlight.where(ioi_id: (CipCompany.where(cip_id: @cip.id).pluck(:ioi_id) + CipSponsor.where(cip_id: @cip.id).pluck(:ioi_id)),highlight_id: @highlight.id)
      @ioi_highlights.each do |ioi_highlight|
        ioi_highlight.destroy
      end  
      if @type == 1
        redirect_to "/cips/#{ @cip.id }/companies", :notice => "#{@highlight.name} removed."
      else
        redirect_to "/cips/#{ @cip.id }/sponsors", :notice => "#{@highlight.name} removed."
      end
    end 
  end

  def edit
    @ioi_highlight = IoiHighlight.find(params[:id])
  end

  def update
    @ioi_highlight = IoiHighlight.find(params[:id])

    @ioi_highlight.ioi_id = params[:ioi_id]
    @ioi_highlight.highlight_id = params[:highlight_id]
    if params[:detail].nil?
      @ioi_highlight.detail = "N/A"
    else
      @ioi_highlight.detail = params[:detail]
    end 
   

    if @ioi_highlight.save
      redirect_to "/ioi_highlights/#{ioi_highlight.id}/", :notice => "IOI Highlight updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @ioi_highlight = IoiHighlight.find(params[:id]) 
    
    @ioi_highlight.destroy

    respond_to do |format|
      format.html do
        redirect_to "/ioi_highlights/", :notice => "IOI Highlight deleted."
      end
      format.js do
        render('destroy.js.erb')
      end
    end
  end

  def import
    IoiHighlight.import(params[:file])
    redirect_to "/models/", notice: "IOI Highlights imported."
  end
end
