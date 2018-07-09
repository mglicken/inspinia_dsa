class LoiHighlightsController < ApplicationController

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
    @loi_highlights = LoiHighlight.all

    respond_to do |format|
      format.html
      format.csv {send_data @loi_highlights.to_csv }
    end
  end

  def show
    @loi_highlights = LoiHighlight.all
    @loi_highlight = LoiHighlight.find(params[:id])
  end

  def new
    @loi_highlight = LoiHighlight.new
  end

  def create
    @loi_highlight = LoiHighlight.new
    @loi_highlight.loi_id = params[:loi_id]
    @loi_highlight.highlight_id = params[:highlight_id]
    if params[:detail].nil?
      @loi_highlight.detail = "N/A"
    else
      @loi_highlight.detail = params[:detail]
    end   
    respond_to do |format|
      format.html do
        if @loi_highlight.save
          redirect_to "/mps/#{ params[:loi_id] }/companies", :notice => "#{@loi_highlight.highlight.name} Highlight added successfully."
        else
          render 'new'
        end
      end
        
      format.js do
        @loi_highlight.save
        render('create.js.erb')
      end
    end
  end

  def checkbox
    @status = params[:status].to_i
    @highlight = Highlight.find(params[:highlight_id])
    @mp = Mp.find(params[:mp_id])
    @type = params[:type_id].to_i
    if @status == 1
      @lois = Loi.where(id: (MpCompany.where(mp_id: @mp.id).pluck(:loi_id) + MpSponsor.where(mp_id: @mp.id).pluck(:loi_id)))
      @lois.order("name ASC").each do |loi|
        loi_highlight = LoiHighlight.new
        loi_highlight.highlight_id = @highlight.id
        loi_highlight.loi_id = loi.id
        loi_highlight.detail = "N/A"
        loi_highlight.save
      end  
      if @type == 1
        redirect_to "/mps/#{ @mp.id }/companies", :notice => "#{@highlight.name} added successfully."
      else
        redirect_to "/mps/#{ @mp.id }/sponsors", :notice => "#{@highlight.name} added successfully."
      end
    else
      @loi_highlights = LoiHighlight.where(loi_id: (MpCompany.where(mp_id: @mp.id).pluck(:loi_id)+MpSponsor.where(mp_id: @mp.id).pluck(:loi_id)),highlight_id: @highlight.id)
      @loi_highlights.each do |loi_highlight|
        loi_highlight.destroy
      end  
      if @type == 1
        redirect_to "/mps/#{ @mp.id }/companies", :notice => "#{@highlight.name} removed."
      else
        redirect_to "/mps/#{ @mp.id }/sponsors", :notice => "#{@highlight.name} removed."
      end
    end 
  end

  def edit
    @loi_highlight = LoiHighlight.find(params[:id])
  end

  def update
    @loi_highlight = LoiHighlight.find(params[:id])

    @loi_highlight.loi_id = params[:loi_id]
    @loi_highlight.highlight_id = params[:highlight_id]
    if params[:detail].nil?
      @loi_highlight.detail = "N/A"
    else
      @loi_highlight.detail = params[:detail]
    end 
   

    if @loi_highlight.save
      redirect_to "/loi_highlights/#{loi_highlight.id}/", :notice => "LOI Highlight updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @loi_highlight = LoiHighlight.find(params[:id]) 
    
    @loi_highlight.destroy

    respond_to do |format|
      format.html do
        redirect_to "/loi_highlights/", :notice => "LOI Highlight deleted."
      end
      format.js do
        render('destroy.js.erb')
      end
    end
  end

  def import
    LoiHighlight.import(params[:file])
    redirect_to "/models/", notice: "LOI Highlights imported."
  end
end
