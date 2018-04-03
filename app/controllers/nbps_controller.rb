class NbpsController < ApplicationController

#before_action :ensure_access

  def ensure_access
    if current_user.access_id.present?
      if current_user.access_id > 3
        redirect_to root_url, :alert => "Not Authorized"
      end
    end
  end

  def index
    @nbps = Nbp.all

    respond_to do |format|
      format.html
      format.csv {send_data @nbps.to_csv }
    end
  end

  def search
    @text = params[:search].downcase
    nbp_ids = []
    Nbp.all.each do |nbp|
      if nbp.name.downcase.include? @text
        nbp_ids.push(nbp.id)
      end
    end
    @nbps=Nbp.where(id: nbp_ids)
  end

  def show
    @nbp = Nbp.find(params[:id])
    a = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    b=""
    for i in 0..63
      b=b+a[rand(35)]
    end
    @p_id = b
    @url = "/create_nbp_slide/#{params[:id]}"
  end

  def show_sponsors
    @nbp = Nbp.find(params[:id])
    @nbp_sponsors = @nbp.nbp_sponsors
    @sponsors = @nbp.sponsors
  end
  
  def show_companies
    @nbp = Nbp.find(params[:id])
    @nbp_companies = @nbp.nbp_companies
    @companies = @nbp.companies
    @buckets = @nbp.buckets
    respond_to do |format|
      format.html
      format.csv {send_data @nbp_companies.to_csv_client }
    end
  end

  def new
    @nbp = Nbp.new
  end
 

  def create
    @nbp = Nbp.new


    @nbp.deal_id = params[:deal_id]
    @nbp.nbp_date = params[:nbp_date]
    @nbp.image_id = params[:image_id]
    @nbp.name = params[:name]

    if @nbp.save
      @bucket = Bucket.new
      @bucket.title = "Category 1"
      @nbp_id = @nbp.id
      redirect_to "/nbps", :notice => "nbp created successfully."
    else
      render 'new'
    end
  end

  def copy_layout
    @nbp = Nbp.find(params[:nbp_id])
    @slide_layout = SlideLayout.new

    @slide_layout.name = @nbp.name
    @slide_layout.date = Date.today
    @slide_layout.user_id = current_user.id
    @slide_layout.deal_id = @nbp.deal_id

    if @slide_layout.save
      @nbp.slides.each do |slide|
        sls = SlideLayoutSlide.new
        sls.slide_id = slide.id
        sls.slide_layout_id = @slide_layout.id
        sls.save
      end
      redirect_to "/slide_layouts/#{@slide_layout.id}", :notice => "NBP Layout copied successfully."
    else
      render 'new'
    end
  end

  def edit
    @nbp = Nbp.find(params[:id])
  end

  def update
    @nbp = Nbp.find(params[:id])

    @nbp.deal_id = params[:deal_id]
    @nbp.nbp_date = params[:nbp_date]
    @nbp.image_id = params[:image_id]
    @nbp.name = params[:name]

    if @nbp.save
      redirect_to "/nbps", :notice => "NBP updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @nbp = Nbp.find(params[:id])

    @nbp.destroy

    redirect_to "/nbps", :notice => "NBP deleted."
  end

  def import
    Nbp.import(params[:file])
    redirect_to "/models/", notice: "NBPs imported."
  end

  def import_strategics

    NbpCompany.import(params[:file])
    redirect_to "/nbps/#{1}/companies", notice: "Strategic Acquirers imported."
  end

  def import_financials
    NbpSponsor.import(params[:file])
    redirect_to "/nbps/#{1}/sponsors", notice: "Financial Acquirers imported."
  end

end
