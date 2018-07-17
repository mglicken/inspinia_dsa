class QovesController < ApplicationController

before_action :ensure_banker_access,  only: [:new, :create, :copy_layout, :edit, :update, :destroy, :import]
before_action :ensure_view_access,  only: [:index, :search, :show]

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
    @qoves = Qofe.all

    respond_to do |format|
      format.html
      format.csv {send_data @qoves.to_csv }
    end
  end

  def show
    @qofe = Qofe.find(params[:id])
    @tags = Tag.where(id: SlideTag.where(slide_id: @qofe.slides.ids).pluck(:tag_id))
    a = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    b=""
    for i in 0..63
      b=b+a[rand(35)]
    end
    @p_id = b
    @url = "/create_qofe_slide/#{params[:id]}"
  end

  def new
    @qofe = Qofe.new
  end

  def create
    @qofe = Qofe.new

    @qofe.name = params[:name]
    @qofe.deal_id = params[:deal_id]
    @qofe.qofe_date = params[:qofe_date]
    @qofe.image_id = params[:image_id]


    if @qofe.save
      redirect_to "/qoves/#{@qofe.id}", :notice => "QofE created successfully."
    else
      render 'new'
    end
  end

  def edit
    @qofe = Qofe.find(params[:id])
  end

  def update
    @qofe = Qofe.find(params[:id])

    @qofe.name = params[:name]
    @qofe.deal_id = params[:deal_id]
    @qofe.qofe_date = params[:qofe_date]
    @qofe.image_id = params[:image_id]

    if @qofe.save
      redirect_to "/qoves/#{@qofe.id}", :notice => "QofE updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @qofe = Qofe.find(params[:id])

    @qofe.destroy

    redirect_to "/qoves", :notice => "QofE deleted."
  end

  def import
    Qofe.import(params[:file])
    redirect_to "/models/", notice: "QofEs imported"
  end
end
