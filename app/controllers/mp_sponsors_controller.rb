class MpSponsorsController < ApplicationController

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
    @mp_sponsors = MpSponsor.all

    respond_to do |format|
      format.html
      format.csv {send_data @mp_sponsors.to_csv }
    end
  end


  def show
    @mp_sponsor = MpSponsor.find(params[:id])
  end

  def new
    @mp_sponsor = MpSponsor.new
  end

  def create
    @mp_sponsor = MpSponsor.new

    @mp_sponsor.mp_id = params[:mp_id]
    @mp_sponsor.sponsor_id = params[:sponsor_id]
    @mp_sponsor.mp_date = params[:mp_date]
    @loi = Loi.new
    @loi.name = @mp_sponsor.mp.deal.company.name + " / " + @mp_sponsor.sponsor.name + " LOI"
    @loi.deal_id = @mp_sponsor.mp.deal_id
    @loi.loi_date = Date.current
    @loi.save
    @mp_sponsor.loi_id = params[:loi_id]

    #Create LoiHighlights for each Highlight associated with other LOIs
    if LoiHighlight.where(loi_id: (@mp_sponsor.mp.mp_sponsors.pluck(:loi_id) + @mp_sponsor.mp.mp_companies.pluck(:loi_id)).uniq).present?
      Highlight.where(id: LoiHighlight.where(loi_id: (@mp_sponsor.mp.mp_sponsors.pluck(:loi_id) + @mp_sponsor.mp.mp_companies.pluck(:loi_id)).uniq).pluck(:highlight_id).uniq).each do |highlight|
        loi_highlight = LoiHighlight.new
        loi_highlight.loi_id = @loi.id
        loi_highlight.highlight_id = highlight.id
        loi_highlight.detail = "N/A"
        loi_highlight.save
      end
    end
    if @mp_sponsor.save
      redirect_to "/mps/#{@mp_sponsor.mp_id}/acquirers", :notice => "MP Sponsor created successfully."
    else
      render 'new'
    end
  end

  def create_by_name
    @mp = Mp.find(params[:mp_id])
    @sponsor_name = params[:name]
    @mp_sponsor = MpSponsor.new
    @mp_sponsor.mp_id = @mp.id
    if Sponsor.find_by(name: @sponsor_name).present?
      @sponsor = Sponsor.find_by(name: @sponsor_name)
      @mp_sponsor.sponsor_id = @sponsor.id
    else
      @sponsor = Sponsor.new
      @sponsor.name = @sponsor_name
      @sponsor.save
      @mp_sponsor.sponsor_id = @sponsor.id
    end

    if @mp_sponsor.save
      redirect_to "/mps/#{ params[:mp_id] }/acquirers", :notice => "\"#{@sponsor_name}\" added to \"#{@mp.name}\" successfully."
    else
      render 'new'
    end
  end

  def edit
    @mp_sponsor = MpSponsor.find(params[:id])
  end

  def update
    @mp_sponsor = MpSponsor.find(params[:id])

    @mp_sponsor.mp_id = params[:mp_id]
    @mp_sponsor.sponsor_id = params[:sponsor_id]
    @mp_sponsor.mp_date = params[:mp_date]
    @mp_sponsor.loi_id = params[:loi_id]

    if @mp_sponsor.save
      redirect_to "/mp_sponsors/#{@mp_sponsor.id}/", :notice => "MP Sponsor updated successfully!"
    else
      render 'edit'
    end
  end

  def update_status
    @mp_sponsor = MpSponsor.find(params[:id])
    @sponsor = @mp_sponsor.sponsor
    @mp = @mp_sponsor.mp
    @status = params[:status].to_i

    if @status == 1
      if @mp_sponsor.loi.present?
        @loi = @mp_sponsor.loi
        @loi.destroy
        @mp_sponsor.loi_id = nil
        @mp_sponsor.declined = true
      else
        @loi=nil
        if @mp_sponsor.declined == true  
          @mp_sponsor.declined = false        
        else
          @mp_sponsor.declined = true
        end
      end
    else
      @loi = Loi.new
      @loi.name = @mp.deal.company.name + " / " + @sponsor.name + " LOI"
      @loi_date = Date.current
      @loi.deal_id = @mp.deal_id
      @loi.save
      @mp_sponsor.loi_id = @loi.id
      @mp_sponsor.declined = false
      #Create LoiHighlights for each Highlight associated with other LOIs
      if LoiHighlight.where(loi_id: (@mp_sponsor.mp.mp_sponsors.pluck(:loi_id) + @mp_sponsor.mp.mp_companies.pluck(:loi_id)).uniq).present?
        Highlight.where(id: LoiHighlight.where(loi_id: (@mp_sponsor.mp.mp_sponsors.pluck(:loi_id) + @mp_sponsor.mp.mp_companies.pluck(:loi_id)).uniq).pluck(:highlight_id).uniq).each do |highlight|
          loi_highlight = LoiHighlight.new
          loi_highlight.loi_id = @loi.id
          loi_highlight.highlight_id = highlight.id
          loi_highlight.save
        end
      end

    end


    if @mp_sponsor.save
      respond_to do |format|
        format.js do
          render('update.js.erb')
        end
      end
    else
    redirect_to "/mps/<%= @mp.id%>/sponsors", notice: "Error"
    end
  end

  def destroy
    @mp_sponsor = MpSponsor.find(params[:id])

    @mp_sponsor.destroy

    redirect_to "/mps/#{@mp_sponsor.mp_id}/sponsors", :notice => "MP Sponsor deleted."
  end
  
  def import
    MpSponsor.import(params[:file])
    redirect_to "/models/", notice: "MP Sponsors imported"
  end
end
