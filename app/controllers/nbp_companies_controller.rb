class NbpCompaniesController < ApplicationController

before_action :ensure_admin_access,  only: [:index, :show, :import]
before_action :ensure_banker_access,  only: [:new, :create, :edit, :update, :update_nbp_companies, :destroy]

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
    @nbp_companies = NbpCompany.all
        respond_to do |format|
      format.html
      format.csv {send_data @nbp_companies.to_csv }
    end
  end

  def show
    @nbp_company = NbpCompany.find(params[:id])
  end

  def new
    @nbp_company = NbpCompany.new
  end

  def create
    @nbp_company = NbpCompany.new


    @nbp_company.company_id = params[:company_id]
    @nbp_company.nbp_id = params[:nbp_id]
    @nbp_company.tier_id = params[:tier_id]
    @nbp_company.bucket_id = params[:bucket_id]
    @nbp_company.include_strip = params[:include_strip]    
    @nbp_company.strip = params[:strip]    
    @nbp_company.note = params[:note]        


    if @nbp_company.save

      @nbp_company.nbp.nbp_tags.each do |nbp_tag|
        strip_tag = StripTag.new
        strip_tag.tag_id = nbp_tag.tag_id
        strip_tag.nbp_company_id = @nbp_company.id
        strip_tag.save
      end
      redirect_to "/nbps/#{@nbp_company.nbp_id}/companies", :notice => "#{@nbp_company.company.name} created successfully."
    else
      render 'new'
    end
  end

  def create_by_name
    @nbp = Nbp.find(params[:nbp_id])
    @company_name = params[:name]
    @nbp_company = NbpCompany.new
    @nbp_company.nbp_id = @nbp.id
    @nbp_company.tier_id = params[:tier_id]
    @nbp_company.bucket_id = params[:bucket_id]


    if Company.find_by(name: @company_name).present?
      @company = Company.find_by(name: @company_name)
      @nbp_company.company_id = @company.id
    else
      @company = Company.new
      @company.name = @company_name
      @company.save
      @nbp_company.company_id = @company.id
    end

    if @nbp_company.save
      @nbp.nbp_tags.each do |nbp_tag|
        strip_tag = StripTag.new
        strip_tag.tag_id = nbp_tag.tag_id
        strip_tag.nbp_company_id = @nbp_company.id
        strip_tag.save
      end
      redirect_to "/nbps/#{ params[:nbp_id] }/companies", :notice => "\"#{@company_name}\" added to \"#{@nbp_company.bucket.title}\" successfully."
    else
      render 'new'
    end
  end

  def edit
    @nbp_company = NbpCompany.find(params[:id])
  end

  def update
    @nbp_company = NbpCompany.find(params[:id])

    @nbp_company.company_id = params[:company_id]
    @nbp_company.nbp_id = params[:nbp_id]
    @nbp_company.tier_id = params[:tier_id]
    @nbp_company.bucket_id = params[:bucket_id]
    @nbp_company.include_strip = params[:include_strip]    
    @nbp_company.strip = params[:strip]    
    @nbp_company.note = params[:note]
    table = params[:table]      

    if @nbp_company.save
      if table
        redirect_to "/nbps/#{@nbp_company.nbp_id}/companies/table", :notice => "#{@nbp_company.company.name} created successfully."
      else
        redirect_to "/nbps/#{@nbp_company.nbp_id}/companies", :notice => "#{@nbp_company.company.name} created successfully."
      end
    else
      render 'edit'
    end
  end

  def update_nbp_companies
    @blocks = params[:layouts].split("c").map { |s| s }
    @ids0 = params[:layouts].split("c").map { |b| b.split(",").map { |s| s.to_i } }
    @ids=[]
    @ids0.each do |block|
      @ids = @ids + block
    end
    @nbp = Nbp.find(NbpCompany.find(@ids.max).nbp_id)
    @buckets = @nbp.buckets.order("id ASC")
    tier = 1
    bucket = 0
    
    @blocks.each do |block|
        @ids = block.split(",").map { |s| s.to_i }
        @ids.each do |id|
            @nbp_company=NbpCompany.find(id)
            @nbp_company.tier_id = tier
            @nbp_company.bucket_id  = @buckets.order("id ASC")[ bucket-1 ].id
            @nbp_company.save
        end
        bucket = bucket + 1
        if bucket == 5
          bucket = 1
          tier = tier + 1
        end 
    end
   
    if @nbp_company.save
      redirect_to "/nbps/#{@nbp.id}/companies", :notice => "Strategic Buyer buckets updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @nbp_company = NbpCompany.find(params[:id])
    table = params[:table]
    @nbp_company.destroy

    respond_to do |format|
      format.html do
        redirect_to "/nbps/#{@nbp_company.nbp_id}/companies/table", :notice => "Company removed."
      end
      format.js do
        render('destroy.js.erb')
      end
    end
  end

  def import
    NbpCompany.import(params[:file])
    redirect_to "/models/", notice: "NBP Companies imported."
  end
end
