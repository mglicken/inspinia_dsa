class NdasController < ApplicationController

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
    @ndas = Nda.all

    respond_to do |format|
      format.html
      format.csv {send_data @ndas.to_csv }
    end
  end

  def show
    @nda = Nda.find(params[:id])
    a = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    b=""
    for i in 0..63
      b=b+a[rand(35)]
    end
    @p_id = b
    @url = "/create_nda_slide/#{params[:id]}"
  end

  def new
    @nda = Nda.new
  end

  def create
    @nda = Nda.new


    @nda.name = params[:name]
    @nda.deal_id = params[:deal_id]
    @nda.nda_date = params[:nda_date]
    @nda.image_id = params[:image_id]


    if @nda.save
      redirect_to "/ndas/#{@nda.id}", :notice => "NDA created successfully."
    else
      render 'new'
    end
  end

  def edit
    @nda = Nda.find(params[:id])
  end

  def update
    @nda = Nda.find(params[:id])

    @nda.deal_id = params[:deal_id]
    @nda.nda_date = params[:nda_date]
    @nda.image_id = params[:image_id]
    @nda.name = params[:name]

    @nda.slides.each do |slide|
      slide.ppt_address = @nda.ppt_address
      slide.save
    end

    if @nda.save
      redirect_to "/ndas/#{@nda.id}", :notice => "NDA updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @nda = Nda.find(params[:id])

    @nda.destroy

    redirect_to "/ndas", :notice => "NDA deleted."
  end

  def import
    Nda.import(params[:file])
    redirect_to "/models/", notice: "NDAs imported"
  end
end
