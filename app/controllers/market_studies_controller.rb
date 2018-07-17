class MarketStudiesController < ApplicationController

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
    @market_studies = MarketStudy.all

    respond_to do |format|
      format.html
      format.csv {send_data @market_studies.to_csv }
    end
  end

  def show
    @market_study = MarketStudy.find(params[:id])
    @advisor_type =  AdvisorType.find_by(name: "Market Study")
    @tags = Tag.where(id: SlideTag.where(slide_id: @market_study.slides.ids).pluck(:tag_id))
    a = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    b=""
    for i in 0..63
      b=b+a[rand(35)]
    end
    @p_id = b
    @url = "/create_market_study_slide/#{params[:id]}"
  end

  def new
    @market_study = MarketStudy.new
  end

  def create
    @market_study = MarketStudy.new

    @market_study.name = params[:name]
    @market_study.deal_id = params[:deal_id]
    @market_study.market_study_date = params[:market_study_date]
    @market_study.image_id = params[:image_id]


    if @market_study.save
      redirect_to "/market_studies/#{@market_study.id}", :notice => "Market Study created successfully."
    else
      render 'new'
    end
  end

  def edit
    @market_study = MarketStudy.find(params[:id])
  end

  def update
    @market_study = MarketStudy.find(params[:id])

    @market_study.name = params[:name]
    @market_study.deal_id = params[:deal_id]
    @market_study.market_study_date = params[:market_study_date]
    @market_study.image_id = params[:image_id]

    if @market_study.save
      redirect_to "/market_studies/#{@market_study.id}", :notice => "Market Study updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @market_study = MarketStudy.find(params[:id])

    @market_study.destroy

    redirect_to "/market_studies", :notice => "Market Study deleted."
  end

  def import
    MarketStudy.import(params[:file])
    redirect_to "/models/", notice: "Market Studies imported"
  end
end
