class NbpCompaniesController < ApplicationController
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

    if @nbp_company.save
      redirect_to "/nbps/#{@nbp_company.nbp_id}/companies", :notice => "NBP company created successfully."
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
    
    if @nbp_company.save
      redirect_to "/nbp_companies/#{@nbp_company.id}/", :notice => "NBP Company updated successfully!"
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
    
    i=1
    j=1
    
    @blocks.each do |block|
        @ids = block.split(",").map { |s| s.to_i }
        @ids.each do |id|
            @nbp_company=NbpCompany.find(id)
            @nbp_company.tier_id = i
            @nbp_company.bucket_id  = @nbp.buckets[ j-2 ].id
            @nbp_company.save  
        end
        j=j+1
        if j>4
          j=1
          i=i+1
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

    @nbp_company.destroy

    respond_to do |format|
      format.html do
        redirect_to "/nbps/#{params[:id]}/companies", :notice => "Company removed."
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
