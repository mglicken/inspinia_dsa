class IoisController < ApplicationController

before_action :ensure_view_access,  only: [:index]
before_action :ensure_banker_access,  only: [:new, :create, :edit, :update, :destroy, :import]
before_action :ensure_view_access,  only: [:show]

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
    @iois = Ioi.all

    respond_to do |format|
      format.html
      format.csv {send_data @iois.to_csv }
    end
  end

  def show
    @ioi = Ioi.find(params[:id])
    a = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    b=""
    for i in 0..63
      b=b+a[rand(35)]
    end
    @p_id = b
    @url = "/create_ioi_slide/#{params[:id]}"
  end

  def new
    @ioi = Ioi.new
  end

  def create
    @ioi = Ioi.new


    @ioi.name = params[:name]
    @ioi.deal_id = params[:deal_id]
    @ioi.ioi_date = params[:ioi_date]
    @ioi.image_id = params[:image_id]
    @ioi.low_purchase_price = params[:low_purchase_price]
    @ioi.high_purchase_price = params[:high_purchase_price]

    if @ioi.save
      redirect_to "/iois/#{@ioi.id}", :notice => "IOI created successfully."
    else
      render 'new'
    end
  end

  def edit
    @ioi = Ioi.find(params[:id])
  end

  def update
    @ioi = Ioi.find(params[:id])

    @ioi.name = params[:name]
    @ioi.deal_id = params[:deal_id]
    @ioi.ioi_date = params[:ioi_date]
    @ioi.image_id = params[:image_id]
    @ioi.low_purchase_price = params[:low_purchase_price]
    @ioi.high_purchase_price = params[:high_purchase_price]
    
    @ioi.slides.each do |slide|
      slide.ppt_address = @ioi.ppt_address
      slide.save
    end

    if @ioi.save
      redirect_to "/iois/#{@ioi.id}", :notice => "IOI updated successfully."
    else
      render 'edit'
    end
  end

  def update_ioi_and_highlights

    ids = params[:ids]

    details = params[:details]
    @ioi = Ioi.find(params[:ioi_id])
    @ioi.name = details[1]
    @ioi.deal_id = details[2].to_i
    @ioi.ioi_date = details[3]
    @ioi.low_purchase_price = details[5]
    @ioi.high_purchase_price = details[6]
    counter = 8
    ids[7..(ids.count-1)].each do |id|

      ioi_highlight = IoiHighlight.find(id.to_i)
      ioi_highlight.detail = details[(counter-1)]
      ioi_highlight.save

      counter = counter + 1
    end

    if @ioi.save
      redirect_to "/iois/#{@ioi.id}", :alert => "IOI updated successfully."
    else
      redirect_to "/iois/#{@ioi.id}", :alert => "IOI update failed."
    end

  end

  def destroy
    @ioi = Ioi.find(params[:id])

    @cip =@ioi.deal.cip
    @ioi.destroy

    redirect_to "/cips/<%= @cip.id %>/sponsors", :notice => "IOI deleted."
  end

  def import
    Ioi.import(params[:file])
    redirect_to "/models/", notice: "IOIs imported"
  end
end
