class MpsController < ApplicationController

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
    @mps = Mp.all

    respond_to do |format|
      format.html
      format.csv {send_data @mps.to_csv }
    end
  end

  def search
    @text = params[:search].downcase
    mp_ids = []
    Mp.all.each do |mp|
      if mp.name.downcase.include? @text
        mp_ids.push(mp.id)
      end
    end
    @mps=Mp.where(id: mp_ids)
  end

  def show
    @mp = Mp.find(params[:id])
    a = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    b=""
    for i in 0..63
      b=b+a[rand(35)]
    end
    @p_id = b
    @url = "/create_mp_slide/#{params[:id]}"
  end

  def show_acquirers
    @mp = Mp.find(params[:id])
    @mp_sponsors = @mp.mp_sponsors
    @mp_companies = @mp.mp_companies
    @lois = Loi.where(id: (@mp_sponsors.pluck(:loi_id) + @mp_companies.pluck(:loi_id)))
    @declined = (@mp_sponsors.where(declined: true) + @mp_companies.where(declined: true)) 
    @sponsors = @mp.sponsors.order("name ASC")
    @companies = @mp.companies.order("name ASC")
    @acquirers = (@companies + @sponsors).sort! { |a, b| a.name <=> b.name } 

    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="' + @mp.deal.company.name + ' LOI Summary.xlsx"'
        }
    end
  end

  def show_sponsors
    @mp = Mp.find(params[:id])
    @mp_sponsors = @mp.mp_sponsors
    @lois = Loi.where(id: @mp_sponsors.pluck(:loi_id))
    @declined = @mp_sponsors.where(declined: true)

    @sponsors = @mp.sponsors.order("name ASC")
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Financial_Acquirers_List.xlsx"'
        }
    end
  end
  
  def show_companies
    @mp = Mp.find(params[:id])
    @mp_companies = @mp.mp_companies
    @lois = Loi.where(id: @mp_companies.pluck(:loi_id))
    @declined = @mp_companies.where(declined: true)

    @companies = @mp.companies.order("name ASC")
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Strategic_Acquirers_List.xlsx"'
        }
    end
  end

  def new
    @mp = Mp.new
  end

  def create
    @mp = Mp.new

    @mp.deal_id = params[:deal_id]
    @mp.mp_date = params[:mp_date]
    @mp.image_id = params[:image_id]
    @mp.name = params[:name]


    if @mp.save
      redirect_to "/mps", :notice => "MP created successfully."
    else
      render 'new'
    end
  end

  def copy_layout
    @mp = mp.find(params[:mp_id])
    @slide_layout = SlideLayout.new

    @slide_layout.name = @mp.name
    @slide_layout.date = Date.today
    @slide_layout.user_id = current_user.id
    @slide_layout.deal_id = @mp.deal_id

    if @slide_layout.save
      @mp.slides.each do |slide|
        sls = SlideLayoutSlide.new
        sls.slide_id = slide.id
        sls.slide_layout_id = @slide_layout.id
        sls.save
      end
      redirect_to "/slide_layouts/#{@slide_layout.id}", :notice => "MP Layout copied successfully."
    else
      render 'new'
    end
  end

  def edit
    @mp = Mp.find(params[:id])
  end

  def update
    @mp = Mp.find(params[:id])

    @mp.deal_id = params[:deal_id]
    @mp.mp_date = params[:mp_date]
    @mp.image_id = params[:image_id]
    @mp.name = params[:name]
    @mp.ppt_address = params[:ppt_address]

    @mp.slides.each do |slide|
      slide.ppt_address = @mp.ppt_address
      slide.save
    end

    if @mp.save
      redirect_to "/mps/#{@mp.id}", :notice => "MP updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @mp = Mp.find(params[:id])

    @mp.destroy

    redirect_to "/mps", :notice => "MP deleted."
  end

  def import
    Mp.import(params[:file])
    redirect_to "/models/", notice: "MPs imported"
  end

  def import_acquirers
    @mp = Mp.find(params[:id])
    Mp.import_acquirers(params[:file], params[:id])
    redirect_to "/mps/#{@mp.id}/acquirers" , notice: "MP Acquirers imported..."
  end
end
