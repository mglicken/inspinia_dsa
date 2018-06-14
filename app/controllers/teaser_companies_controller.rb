class TeaserCompaniesController < ApplicationController

before_action :ensure_admin_access,  only: [:index, :show, :import]
before_action :ensure_banker_access,  only: [:new, :create, :edit, :update, :destroy]


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
    @teaser_companies = TeaserCompany.all

    respond_to do |format|
      format.html
      format.csv {send_data @teaser_companies.to_csv }
    end
  end


  def show
    @teaser_company = TeaserCompany.find(params[:id])
  end

  def new
    @teaser_company = TeaserCompany.new
  end

  def create
    @teaser_company = TeaserCompany.new

    @teaser_company.teaser_id = params[:teaser_id]
    @teaser_company.company_id = params[:company_id]

    @nda = Nda.new
    @nda.name = @teaser_company.teaser.deal.company.name + " / " + @teaser_company.company.name + " NDA"
    @nda.deal_id = @teaser_company.teaser.deal_id
    @nda.nda_date = @teaser_company.teaser.teaser_date
    @nda.save

    @teaser_company.nda_id = @nda.id

    if @teaser_company.save
      redirect_to "/ndas", :notice => "Teaser Company created successfully."
    else
      render 'new'
    end
  end

  def create_by_name
    @teaser = Teaser.find(params[:teaser_id])
    @company_name = params[:name]
    @teaser_company = TeaserCompany.new
    @teaser_company.teaser_id = @teaser.id
    if Company.find_by(name: @company_name).present?
      @company = Company.find_by(name: @company_name)
      @teaser_company.company_id = @company.id
    else
      @company = Company.new
      @company.name = @company_name
      @company.save
      @teaser_company.company_id = @company.id
    end
    @nda = Nda.new
    @nda.name = @teaser.deal.company.name + " / " + @company.name + " NDA"
    @nda.deal_id = @teaser.deal_id
    @nda.nda_date = @teaser.teaser_date
    @nda.save

    @teaser_company.nda_id = @nda.id

    if @teaser_company.save
      redirect_to "/teasers/#{ params[:teaser_id] }/companies", :notice => "\"#{@company_name}\" added to \"#{@teaser.name}\" successfully."
    else
      render 'new'
    end
  end

  def edit
    @teaser_company = TeaserCompany.find(params[:id])
  end

  def update
    @teaser_company = TeaserCompany.find(params[:id])

    @teaser_company.teaser_id = params[:teaser_id]
    @teaser_company.company_id = params[:company_id]
    @teaser_company.nda_id = params[:nda_id]

    if @teaser_company.save
      redirect_to "/teaser_companies/#{@teaser_company.id}/", :notice => "Teaser Company updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @teaser_company = TeaserCompany.find(params[:id])

    @teaser_company.destroy

    redirect_to "/teasers/#{@teaser_company.teaser_id}", :notice => "Teaser Company deleted."
  end
  
  def import
    TeaserCompany.import(params[:file])
    redirect_to "/models/", notice: "Teaser Companies imported"
  end
end
