class DealsController < ApplicationController
  def index
    @deals = Deal.all

    respond_to do |format|
      format.html
      format.csv {send_data @deals.to_csv }
    end
  end

  def rgen
    a = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    b=""
    for i in 0..35
      b=b+a[rand(35)]
    end
    @code = b 
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
    
    @tags = []
    Tag.all.each do |tag|
      if tag.name.downcase.include? @text
        @tags.push(tag.id)
      end
    end
    @slides = Slide.find(SlideTag.where(tag_id: @tags).pluck(:slide_id).uniq)
    
    @deals = []
    Deal.all.each do |deal|
      if deal.name.downcase.include? @text
        @deals.push(deal.id)
      end
    end
    
    @nbps = []
    Nbp.all.each do |nbp|
      if nbp.name.downcase.include? @text
        @nbps.push(nbp.id)
      end
    end

    @notes = []
    Note.all.each do |note|
      if note.detail.downcase.include? @text
        @notes.push(note.id)
      end
    end

    @cips = []
    Cip.all.each do |cip|
      if cip.name.downcase.include? @text
        @cips.push(cip.id)
      end
    end

    @mps = []
    Mp.all.each do |mp|
      if mp.name.downcase.include? @text
        @mps.push(mp.id)
      end
    end

    @companies = []
    Company.all.each do |company|
      if company.name.downcase.include? @text
        @companies.push(company.id)
      end
    end
    
    @sponsors = []
    Sponsor.all.each do |sponsor|
      if sponsor.name.downcase.include? @text
        @sponsors.push(sponsor.id)
      end
    end
    
    @funds = []
    Fund.all.each do |fund|
      if fund.name.downcase.include? @text
        @funds.push(fund.id)
      end
    end
    Sponsor.where(id: @sponsors).each do |sponsor|
      sponsor.funds.each do |fund|
        @funds.push(fund.id)
      end
    end
    @funds = @funds.uniq

    @people = []
    Person.all.each do |person|
      if person.name.downcase.include? @text
        @people.push(person.id)
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
    redirect_to "/deals/", notice: "Deals imported"
  end
end
