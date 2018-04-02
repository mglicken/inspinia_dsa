class DealsController < ApplicationController

#before_action :ensure_access

  def ensure_access
    if current_user.access_id.present?
      if current_user.access_id > 3
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

  def show
    @deal = Deal.find(params[:id])
  end

  def new
    @deal = Deal.new
    
  end

  def create
    @deal = Deal.new
    nbp = Nbp.new
    cip = Cip.new
    mp = Mp.new
    teaser = Teaser.new
    @deal.name = params[:name]
    @deal.company_id = params[:company_id]


    if @deal.save
          nbp.deal_id = @deal.id
          cip.deal_id = @deal.id
          mp.deal_id = @deal.id
          teaser.deal_id = @deal.id
          nbp.name = @deal.name + ' NBP'
          cip.name = @deal.name + ' CIP'
          mp.name = @deal.name + ' MP'
          if nbp.save
            cip.save
            mp.save
            teaser.save            
            redirect_to "/deals", :notice => "Deal created successfully."
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
    nbp = Nbp.find_by(deal_id: params[:id])
    cip = Cip.find_by(deal_id: params[:id])
    mp = Mp.find_by(deal_id: params[:id])

    @deal.name = params[:name]
    @deal.company_id = params[:company_id]

    if @deal.save
          if nbp.save
            cip.save
            mp.save
            redirect_to "/deals", :notice => "Deal created successfully."
          else
            render 'new'
          end
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
