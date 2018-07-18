class CipsController < ApplicationController

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
    @cips = Cip.all

    respond_to do |format|
      format.html
      format.csv {send_data @cips.to_csv }
    end
  end

  def search
    @text = params[:search].downcase
    cip_ids = []
    Cip.all.each do |cip|
      if cip.name.downcase.include? @text
        cip_ids.push(cip.id)
      end
    end
    @cips=Cip.where(id: cip_ids)
  end

  def show
    @cip = Cip.find(params[:id])
    a = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    b=""
    for i in 0..63
      b=b+a[rand(35)]
    end
    @p_id = b
    @url = "/create_cip_slide/#{params[:id]}"
  end

  def show_companies
    @cip = Cip.find(params[:id])
    @cip_companies = @cip.cip_companies
    @iois = Ioi.where(id: @cip_companies.pluck(:ioi_id))
    @declined = @cip_companies.where(declined: true)

    @companies = @cip.companies.order("name ASC")
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="All_Acquirers_List.xlsx"'
        }
    end
  end

  def show_sponsors
    @cip = Cip.find(params[:id])
    @cip_sponsors = @cip.cip_sponsors
    @iois = Ioi.where(id: @cip_sponsors.pluck(:ioi_id))
    @declined = @cip_sponsors.where(declined: true)

    @sponsors = @cip.sponsors.order("name ASC")
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="All_Acquirers_List.xlsx"'
        }
    end
  end
  
  def show_acquirers
    @cip = Cip.find(params[:id])
    @cip_sponsors = @cip.cip_sponsors
    @cip_companies = @cip.cip_companies
    @iois = Ioi.where(id: (@cip_sponsors.pluck(:ioi_id) + @cip_companies.pluck(:ioi_id)))
    @declined = (@cip_sponsors.where(declined: true) + @cip_companies.where(declined: true)) 
    @sponsors = @cip.sponsors.order("name ASC")
    @companies = @cip.companies.order("name ASC")
    @acquirers = (@companies + @sponsors).sort! { |a, b| a.name <=> b.name } 

    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="' + @cip.deal.company.name + ' IOI Summary.xlsx"'
        }
    end
  end

  def show_advisors
    @cip = Cip.find(params[:id])

    @diligence_advisors = @cip.diligence_advisors
    @people_advisors = Person.where(id: @cip.diligence_advisors.pluck(:person_id)).order("name ASC")
    @company_advisors = Company.where(id: @cip.diligence_advisors.pluck(:company_id)).order("name ASC")
    respond_to do |format|
      format.html
    end
  end

  def new
    @cip = Cip.new
  end

  def create
    @cip = Cip.new

    @cip.name = params[:name]
    @cip.deal_id = params[:deal_id]
    @cip.cip_date = params[:cip_date]
    @cip.net_sales_target = params[:net_sales_target]
    @cip.adj_ebitda_target = params[:adj_ebitda_target]
    @cip.image_id = params[:image_id]
    @cip.ppt_address = params[:ppt_address]

    if @cip.save
      redirect_to "/cips/#{@cip.id}", :notice => "CIP created successfully."
    else
      render 'new'
    end
  end

  def copy_layout
    @cip = Cip.find(params[:cip_id])
    @slide_layout = SlideLayout.new

    @slide_layout.name = @cip.name
    @slide_layout.date = Date.today
    @slide_layout.user_id = current_user.id
    @slide_layout.deal_id = @cip.deal_id

    if @slide_layout.save
      @cip.slides.each do |slide|
        sls = SlideLayoutSlide.new
        sls.slide_id = slide.id
        sls.slide_layout_id = @slide_layout.id
        sls.save
      end
      redirect_to "/slide_layouts/#{@slide_layout.id}", :notice => "CIP Layout copied successfully."
    else
      render 'new'
    end
  end

  def edit
    @cip = Cip.find(params[:id])
  end

  def update
    @cip = Cip.find(params[:id])

    @cip.name = params[:name]
    @cip.deal_id = params[:deal_id]
    @cip.cip_date = params[:cip_date]
    @cip.net_sales_target = params[:net_sales_target]
    @cip.adj_ebitda_target = params[:adj_ebitda_target]
    @cip.image_id = params[:image_id]
    @cip.ppt_address = params[:ppt_address]

    @cip.slides.each do |slide|
      slide.ppt_address = @cip.ppt_address
      slide.save
    end

    if @cip.save
      redirect_to "/cips/#{@cip.id}", :notice => "CIP updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @cip = Cip.find(params[:id])

    @cip.destroy

    redirect_to "/cips", :notice => "CIP deleted."
  end

  def import
    Cip.import(params[:file])
    redirect_to "/models/", notice: "CIPs imported"
  end

  def import_acquirers
    @cip = Cip.find(params[:id])
    Cip.import_acquirers(params[:file], params[:id])
    redirect_to "/cips/#{@cip.id}/acquirers" , notice: "CIP Acquirers imported..."
  end
end
