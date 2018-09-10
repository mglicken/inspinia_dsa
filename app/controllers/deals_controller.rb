class DealsController < ApplicationController

before_action :ensure_banker_access,  only: [:new, :create, :dashboard, :edit, :update, :destroy, :import]
before_action :ensure_view_access,  only: [:index, :search, :search_all, :show]

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
    @deals = Deal.all

    respond_to do |format|
      format.html
      format.csv {send_data @deals.to_csv }
    end
  end

  
  def dashboard
    @person = Person.find(7)

    if @person.blank?
      redirect_to "/deals"
    end
  end
  def search
    @text = params[:search].downcase
    deal_ids = []
    Deal.all.each do |deal|
      if deal.name.downcase.include? @text
        deal_ids.push(deal.id)
      elsif deal.project_alias.nil?
      elsif deal.project_alias.downcase.include? @text
        deal_ids.push(deal.id)
      end
    end
    
    @deals=Deal.where(id: deal_ids)
  end

  def search_all
    @text = params[:search].downcase
    
    @tag_ids = []
    Tag.all.each do |tag|
      if tag.name.downcase.include? @text
        @tag_ids.push(tag.id)
      end
    end
        
    @deal_ids = []
    Deal.all.each do |deal|
      if deal.name.downcase.include? @text
        @deal_ids.push(deal.id)
      elsif deal.project_alias.present?
        if deal.project_alias.downcase.include? @text
          @deal_ids.push(deal.id)
        end
      end
    end
    
    @nbp_ids = []
    Nbp.all.each do |nbp|
      if nbp.name.downcase.include? @text
        @nbp_ids.push(nbp.id)
      end
    end

    @note_ids = []
    Note.all.each do |note|
      if note.detail.downcase.include? @text
        @note_ids.push(note.id)
      end
    end

    @cip_ids = []
    Cip.all.each do |cip|
      if cip.name.downcase.include? @text
        @cip_ids.push(cip.id)
      end
    end

    @mp_ids = []
    Mp.all.each do |mp|
      if mp.name.downcase.include? @text
        @mp_ids.push(mp.id)
      end
    end

    @company_ids = []
    Company.all.each do |company|
      if company.name.downcase.include? @text
        @company_ids.push(company.id)
      end
    end
    
    @sponsor_ids = []
    Sponsor.all.each do |sponsor|
      if sponsor.name.downcase.include? @text
        @sponsor_ids.push(sponsor.id)
      end
    end
    
    @fund_ids = []
    Fund.all.each do |fund|
      if fund.name.downcase.include? @text
        @fund_ids.push(fund.id)
      end
    end
    Sponsor.where(id: @sponsor_ids).each do |sponsor|
      sponsor.funds.each do |fund|
        @fund_ids.push(fund.id)
      end
    end
    @fund_ids = @fund_ids.uniq

    @slide_ids = (SlideTag.where(tag_id: @tag_ids).pluck(:slide_id) + NbpSlide.where(nbp_id: @nbp_ids).pluck(:slide_id) + CipSlide.where(cip_id: @cip_ids).pluck(:slide_id) + MpSlide.where(mp_id: @mp_ids).pluck(:slide_id)).uniq
    @slides = Slide.where(id: @slide_ids)

    @person_ids = []
    Person.all.each do |person|
      if person.name.downcase.include? @text
        @person_ids.push(person.id)
      end
    end
  end

  def follow
    @deal_follow = DealFollow.new

    @deal_follow.deal_id = params[:deal_id]
    @deal_follow.user_id = current_user.id
 
    respond_to do |format|
      format.html do
        if @deal_follow.save
          redirect_to "/deals/#{ params[:deal_id] }", :notice => "Deal followed."
        else
          render 'new'
        end
      end
        
      format.js do
        @deal_follow.save
        render('create_follow.js.erb')
      end
    end
  end

  def unfollow
    @deal_follow = DealFollow.where(deal_id: params[:id], user_id: current_user.id).first
    @deal_follow.destroy

    respond_to do |format|
      format.html do
        redirect_to "/deals/#{params[:id]}", :notice => "Deal unfollowed." 
      end
      format.js do
        render('destroy_follow.js.erb')
      end
    end
  end

  def show
    @deal = Deal.find(params[:id].to_i)
    @followed = DealFollow.find_by(user_id: current_user.id, deal_id: @deal.id).present?
    @advisor_type = AdvisorType.find_by(name: "Legal Advisor")
    @cip = @deal.cips[0]
    @cip_sponsors = @cip.cip_sponsors
    @cip_companies = @cip.cip_companies
    @iois = Ioi.where(id: (@cip_sponsors.pluck(:ioi_id) + @cip_companies.pluck(:ioi_id)))
    @declined = (@cip_sponsors.where(declined: true) + @cip_companies.where(declined: true)) 
    @sponsors = @cip.sponsors.order("name ASC")
    @companies = @cip.companies.order("name ASC")
    @acquirers = (@companies + @sponsors).sort! { |a, b| a.name <=> b.name }
    @engagers = (Company.where(id:@deal.engagement_companies.pluck(:company_id)) + Sponsor.where(id:@deal.engagement_sponsors.pluck(:sponsor_id))).sort! { |a, b| a.name <=> b.name }

  end

  def show_qoves
    @deal = Deal.find(params[:id])
    @followed = DealFollow.find_by(user_id: current_user.id, deal_id: @deal.id).present?
    @advisor_type = AdvisorType.find_by(name: "Legal Advisor")
    @cip = @deal.cips[0]
    @cip_sponsors = @cip.cip_sponsors
    @cip_companies = @cip.cip_companies
    @iois = Ioi.where(id: (@cip_sponsors.pluck(:ioi_id) + @cip_companies.pluck(:ioi_id)))
    @declined = (@cip_sponsors.where(declined: true) + @cip_companies.where(declined: true)) 
    @sponsors = @cip.sponsors.order("name ASC")
    @companies = @cip.companies.order("name ASC")
    @acquirers = (@companies + @sponsors).sort! { |a, b| a.name <=> b.name }
    @engagers = (Deal.where(id:@deal.engagement_companies.pluck(:company_id)) + Sponsor.where(id:@deal.engagement_sponsors.pluck(:sponsor_id))).sort! { |a, b| a.name <=> b.name }
    @qoves = @deal.qoves.order("name ASC")
  end

  def show_market_studies
    @deal = Deal.find(params[:id])
    @followed = DealFollow.find_by(user_id: current_user.id, deal_id: @deal.id).present?
    @advisor_type = AdvisorType.find_by(name: "Legal Advisor")
    @cip = @deal.cips[0]
    @cip_sponsors = @cip.cip_sponsors
    @cip_companies = @cip.cip_companies
    @iois = Ioi.where(id: (@cip_sponsors.pluck(:ioi_id) + @cip_companies.pluck(:ioi_id)))
    @declined = (@cip_sponsors.where(declined: true) + @cip_companies.where(declined: true)) 
    @sponsors = @cip.sponsors.order("name ASC")
    @companies = @cip.companies.order("name ASC")
    @acquirers = (@companies + @sponsors).sort! { |a, b| a.name <=> b.name }
    @engagers = (Deal.where(id:@deal.engagement_companies.pluck(:company_id)) + Sponsor.where(id:@deal.engagement_sponsors.pluck(:sponsor_id))).sort! { |a, b| a.name <=> b.name }
    @market_studies = @deal.market_studies.order("name ASC")
  end

  def option_content
    @deal = Deal.find(params[:id])

    respond_to do |format|
       
      format.js do
        render('update_option_content.js.erb')
      end
    end
  end

  def copy_strategic_acquirers
    @deal = Deal.find(params[:deal_id])
    @select_group = params[:select_group].split("-").map { |s| s }
    if params[:nbp_id].present?
      @nbp = Nbp.find(params[:nbp_id])
      @companies = @nbp.companies
    elsif params[:teaser_id].present?
      @teaser = Teaser.find(params[:teaser_id])
      @companies = @teaser.companies
    elsif params[:cip_id].present?
      @cip = Cip.find(params[:cip_id])
      @companies = @cip.companies
    elsif params[:mp_id].present?
      @mp = Mp.find(params[:mp_id])
      @companies = @mp.companies
    end

    if @select_group[0] == 'nbp'
      @nbp = Nbp.find(@select_group[1].to_i)
      Company.where(id: (@companies.ids - @nbp.companies.ids)).each do |company|
        nbp_company = NbpCompany.new
        nbp_company.nbp_id = @nbp.id
        nbp_company.company_id = company.id
        nbp_company.tier_id = 4
        if @nbp.buckets.count > 0
          nbp_company.bucket_id = @nbp.buckets.first.id
        else
          bucket = Bucket.new
          bucket.title = "Bucket 1"
          bucket.nbp_id = @nbp.id
          bucket.save
          nbp_company.bucket_id = bucket.id          
        end
        nbp_company.save
      end
      redirect_to "/nbps/#{ @select_group[1] }/companies", :notice => "Strategic Acquirers added."
    elsif @select_group[0] == 'teaser'
      @teaser = Teaser.find(@select_group[1].to_i)
      Company.where(id: (@companies.ids - @teaser.companies.ids)).each do |company|
        teaser_company = TeaserCompany.new
        teaser_company.teaser_id = @teaser.id
        teaser_company.company_id = company.id
        nda = Nda.new
        nda.deal_id = @teaser.deal.id
        nda.name = @teaser.deal.company.name + " / " + company.name + " NDA"
        nda.save
        teaser_company.nda_id = nda.id
        teaser_company.save
      end
      redirect_to "/teasers/#{ @select_group[1] }/companies", :notice => "Strategic Acquirers added."
    elsif @select_group[0] == 'cip'
      @cip = Cip.find(@select_group[1].to_i)
      Company.where(id: (@companies.ids - @cip.companies.ids)).each do |company|
        cip_company = CipCompany.new
        cip_company.cip_id = @cip.id
        cip_company.company_id = company.id
        cip_company.save
      end
      redirect_to "/cips/#{ @select_group[1] }/companies", :notice => "Strategic Acquirers added."
    elsif @select_group[0] == 'mp'
      @mp = Mp.find(@select_group[1].to_i)
      Company.where(id: (@companies.ids - @mp.companies.ids)).each do |company|
        mp_company = MpCompany.new
        mp_company.mp_id = @mp.id
        mp_company.company_id = company.id
        mp_company.save
      end
      redirect_to "/mps/#{ @select_group[1] }/companies", :notice => "Strategic Acquirers added."
    end
  end

  def copy_financial_acquirers
  end

  def new
    @deal = Deal.new
  end

  def create
    @deal = Deal.new
    case_study = CaseStudy.new
    nbp = Nbp.new
    cip = Cip.new
    mp = Mp.new
    teaser = Teaser.new
    @deal.name = params[:name]
    @deal.company_id = params[:company_id]
    @deal.project_alias = params[:project_alias]
    @deal.project_code = params[:project_code]
    @deal.deal_stage_id = params[:deal_stage_id]
    @deal.deal_type_id = params[:deal_type_id]

    if @deal.save
        case_study.deal_id = @deal.id
        nbp.deal_id = @deal.id
        cip.deal_id = @deal.id
        mp.deal_id = @deal.id
        teaser.deal_id = @deal.id
        case_study.name = @deal.name + ' CS'
        nbp.name = @deal.name + ' NBP'
        cip.name = @deal.name + ' CIP'
        mp.name = @deal.name + ' MP'
        teaser.name = @deal.name + ' Teaser'

        if nbp.save
          cip.save
          mp.save
          case_study.save
          teaser.save
        
          redirect_to "/deals/#{@deal.id}", :notice => "Deal created successfully."
        else
          render 'new'
        end
    else
      render 'new'
    end
  end

  def edit
    @deal = Deal.find(params[:id])
  end

  def update
    @deal = Deal.find(params[:id])
    @deal.name = params[:name]
    @deal.company_id = params[:company_id]
    @deal.project_alias = params[:project_alias]
    @deal.project_code = params[:project_code]
    @deal.deal_stage_id = params[:deal_stage_id]
    @deal.deal_type_id = params[:deal_type_id]

    if @deal.save
       redirect_to "/deals/#{@deal.id}", :notice => "Deal updated successfully."
    else
      render 'new'
    end
  end

  def destroy
    @deal = Deal.find(params[:id])

    @deal.destroy

    redirect_to "/deals", :notice => "Deal deleted."
  end

  def import
    Deal.import(params[:file])
    redirect_to "/models/", notice: "Deals imported"
  end
end
