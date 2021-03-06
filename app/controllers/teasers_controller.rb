class TeasersController < ApplicationController

before_action :ensure_view_access,  only: [:index]
before_action :ensure_banker_access,  only: [:new, :create, :copy_layout, :edit, :update, :destroy, :import]
before_action :ensure_view_access,  only: [:search, :show]

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
    @teasers = Teaser.all

    respond_to do |format|
      format.html
      format.csv {send_data @teasers.to_csv }
    end
  end

  def show
    @teaser = Teaser.find(params[:id])
    a = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    b=""
    for i in 0..63
      b=b+a[rand(35)]
    end
    @p_id = b
    @url = "/create_teaser_slide/#{params[:id]}"
  end

  def show_sponsors
    @teaser = Teaser.find(params[:id])
    @teaser_sponsors = @teaser.teaser_sponsors
    @sponsors = @teaser.sponsors.order("name ASC")
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Financial_Acquirers_List.xlsx"'
        }
    end
  end
  
  def show_companies
    @teaser = Teaser.find(params[:id])
    @teaser_companies = @teaser.teaser_companies
    @companies = @teaser.companies.order("name ASC")
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Strategic_Acquirers_List.xlsx"'
        }
    end
  end

  def new
    @teaser = Teaser.new
  end

  def create
    @teaser = Teaser.new

    @teaser.name = params[:name]
    @teaser.deal_id = params[:deal_id]
    @teaser.teaser_date = params[:teaser_date]
    @teaser.image_id = params[:image_id]


    if @teaser.save
      redirect_to "/teasers/#{@teaser.id}", :notice => "Teaser created successfully."
    else
      render 'new'
    end
  end

  def copy_layout
    @teaser = Teaser.find(params[:teaser_id])
    @slide_layout = SlideLayout.new

    @slide_layout.name = @teaser.name
    @slide_layout.date = Date.today
    @slide_layout.user_id = current_user.id
    @slide_layout.deal_id = @teaser.deal_id

    if @slide_layout.save
      @teaser.slides.each do |slide|
        sls = SlideLayoutSlide.new
        sls.slide_id = slide.id
        sls.slide_layout_id = @slide_layout.id
        sls.save
      end
      redirect_to "/slide_layouts/#{@slide_layout.id}", :notice => "Teaser Layout copied successfully."
    else
      render 'new'
    end
  end

  def edit
    @teaser = Teaser.find(params[:id])
  end

  def update
    @teaser = Teaser.find(params[:id])

    @teaser.deal_id = params[:deal_id]
    @teaser.name = params[:name]
    @teaser.teaser_date = params[:teaser_date]
    @teaser.image_id = params[:image_id]

    @teaser.ppt_address = params[:ppt_address]

    @teaser.slides.each do |slide|
      slide.ppt_address = @teaser.ppt_address
      slide.save
    end

    if @teaser.save
      redirect_to "/teasers/#{@teaser.id}", :notice => "Teaser updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @teaser = Teaser.find(params[:id])

    @teaser.destroy

    redirect_to "/teasers", :notice => "Teaser deleted."
  end

  def import
    Teaser.import(params[:file])
    redirect_to "/models/", notice: "Teasers imported."
  end
end
