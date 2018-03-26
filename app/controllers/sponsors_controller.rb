class SponsorsController < ApplicationController
  def index
    @sponsors = Sponsor.all

    respond_to do |format|
      format.html
      format.csv {send_data @sponsors.to_csv }
    end
  end

  def search
    @text = params[:search].downcase
    sponsor_ids = []
    Sponsor.all.each do |sponsor|
      if sponsor.name.downcase.include? @text
        sponsor_ids.push(sponsor.id)
      end
    end
    @sponsors=Sponsor.where(id: sponsor_ids)
  end

  def follow
    @sponsor_follow = SponsorFollow.new

    @sponsor_follow.sponsor_id = params[:sponsor_id]
    @sponsor_follow.user_id = current_user.id
 
    respond_to do |format|
      format.html do
        if @sponsor_follow.save
          redirect_to "/sponsors/#{ params[:sponsor_id] }", :notice => "Sponsor followed."
        else
          render 'new'
        end
      end
        
      format.js do
        @sponsor_follow.save
        render('create_follow.js.erb')
      end
    end
  end

  def unfollow
    @sponsor_follow = SponsorFollow.where(sponsor_id: params[:id], user_id: current_user.id).first
    @sponsor_follow.destroy

    respond_to do |format|
      format.html do
        redirect_to "/sponsors/#{params[:id]}", :notice => "Sponsor unfollowed." 
      end
      format.js do
        render('destroy_follow.js.erb')
      end
    end
  end

  def show
    @sponsor = Sponsor.find(params[:id])
    @followed = SponsorFollow.where(sponsor_id: params[:id],user_id: current_user.id).present?
    @funds = @sponsor.funds
    @companies = Company.where(id: FundCompany.where(fund_id: @funds.ids).pluck(:company_id))
    @deals = Deal.where(company_id: @companies.ids)
    @notes = @sponsor.notes
    @people = Person.where(id: SponsorHistory.where(sponsor_id: params[:id]).pluck(:person_id)).order("name ASC")
    @nbps = Nbp.where(id: NbpSponsor.where(sponsor_id:@sponsor.id).pluck(:nbp_id)).order("name ASC")
  end

  def new
    @sponsor = Sponsor.new
  end

  def create
    @sponsor = Sponsor.new

    @sponsor.name = params[:name]
    @sponsor.tier = params[:tier]
    @sponsor.type = params[:type]
    @sponsor.rco_id = params[:rco_id]
    @sponsor.co_id = params[:co_id]
    @sponsor.address = params[:address]
    @sponsor.city = params[:city]
    @sponsor.state = params[:state]
    @sponsor.zip = params[:zip]
    @sponsor.phone = params[:phone]
    @sponsor.web_address = params[:web_address]
    @sponsor.linkedin_url = params[:linkedin_url]
    @sponsor.description = params[:description]
    @sponsor.description_date = Date.today

    if @sponsor.web_address[0..3] == "http" || @sponsor.web_address == ""

    else
      @sponsor.web_address "http://" + params[:web_address]
    end

    if @sponsor.save
      redirect_to "/sponsors/#{@sponsor.id}", :notice => "Sponsor created successfully."
    else
      render 'new'
    end
  end

  def edit
    @sponsor = Sponsor.find(params[:id])
  end

  def update
    @sponsor = Sponsor.find(params[:id])
    @sponsor.name = params[:name]
    @sponsor.tier = params[:tier]
    @sponsor.type = params[:type]
    @sponsor.rco_id = params[:rco_id]
    @sponsor.co_id = params[:co_id]
    @sponsor.address = params[:address]
    @sponsor.city = params[:city]
    @sponsor.state = params[:state]
    @sponsor.zip = params[:zip]
    @sponsor.phone = params[:phone]
    @sponsor.web_address = params[:web_address]
    @sponsor.linkedin_url = params[:linkedin_url]
    @sponsor.description = params[:description]
    if @sponsor.description != params[:description]
      @sponsor.description_date = Date.today
    end    
    if @sponsor.web_address[0..3] == "http" 

    else
      @sponsor.web_address = "http://" + params[:web_address]
    end
    
    if @sponsor.save
      redirect_to "/sponsors/#{@sponsor.id}", :notice => "Sponsor updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @sponsor = Sponsor.find(params[:id])

    @sponsor.destroy

    redirect_to "/sponsors", :notice => "Sponsor deleted."
  end
  def import
    Sponsor.import(params[:file])
    redirect_to "/sponsors/", notice: "Sponsors imported"
  end

end
