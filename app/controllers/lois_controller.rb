class LoisController < ApplicationController

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
    @lois = Loi.all

    respond_to do |format|
      format.html
      format.csv {send_data @lois.to_csv }
    end
  end

  def show
    @loi = Loi.find(params[:id])
    a = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    b=""
    for i in 0..63
      b=b+a[rand(35)]
    end
    @p_id = b
    @url = "/create_loi_slide/#{params[:id]}"
  end

  def new
    @loi = Loi.new
  end

  def create
    @loi = Loi.new


    @loi.name = params[:name]
    @loi.deal_id = params[:deal_id]
    @loi.loi_date = params[:loi_date]
    @loi.image_id = params[:image_id]
    @loi.enterprise_value = params[:enterprise_value]

    if @loi.save
      redirect_to "/lois/#{@loi.id}", :notice => "LOI created successfully."
    else
      render 'new'
    end
  end

  def edit
    @loi = Loi.find(params[:id])
  end

  def update
    @loi = Loi.find(params[:id])

    @loi.name = params[:name]
    @loi.deal_id = params[:deal_id]
    @loi.loi_date = params[:loi_date]
    @loi.image_id = params[:image_id]
    
    @loi.slides.each do |slide|
      slide.ppt_address = @loi.ppt_address
      slide.save
    end

    @loi.name = params[:name]
    @loi.deal_id = params[:deal_id]
    @loi.loi_date = params[:loi_date]
    @loi.image_id = params[:image_id]
    @loi.enterprise_value = params[:enterprise_value]

    if @loi.save
      redirect_to "/lois/#{@loi.id}", :notice => "LOI updated successfully."
    else
      render 'edit'
    end
  end

  def update_loi_and_highlights

    ids = params[:ids]

    details = params[:details]
    @loi = Loi.find(params[:loi_id])
    @loi.name = details[1]
    @loi.deal_id = details[2].to_i
    @loi.loi_date = details[3]
    @loi.enterprise_value = details[4]

    counter = 7
    ids[6..(ids.count-1)].each do |id|

      loi_highlight = LoiHighlight.find(id.to_i)
      loi_highlight.detail = details[(counter-1)]
      loi_highlight.save

      counter = counter + 1
    end

    if @loi.save
      redirect_to "/lois/#{@loi.id}", :alert => "LOI updated successfully."
    else
      redirect_to "/lois/#{@loi.id}", :alert => "LOI update failed."
    end

  end

  def destroy
    @loi = Loi.find(params[:id])
    @cip =@loi.deal.cip
    @loi.destroy

    redirect_to "/cips/<%= @cip.id %>/sponsors", :notice => "LOI deleted."
  end

  def import
    Loi.import(params[:file])
    redirect_to "/models/", notice: "LOIs imported"
  end
end
