class FundsController < ApplicationController

before_action :ensure_access

  def ensure_access
    if current_user.access_id.present?
      if current_user.access_id > 3
        redirect_to root_url, :alert => "Not Authorized"
      end
    end
  end

  def index
    @funds = Fund.all

    respond_to do |format|
      format.html
      format.csv {send_data @funds.to_csv }
    end
  end

  def search
    @text = params[:search].downcase
    fund_ids = []

    sponsors = []
    Sponsor.all.each do |sponsor|
      if sponsor.name.downcase.include? @text
        sponsors.push(sponsor.id)
      end
    end
    
    fund_ids = []
    Fund.all.each do |fund|
      if fund.name.downcase.include? @text
        fund_ids.push(fund.id)
      end
    end

    sponsors.each do |sponsor|
      sponsor.funds.each do |fund|
        fund_ids.push(fund.id)
      end
    end

    @funds= Fund.where(id: fund_ids.uniq)
  end

  def show
    @fund = Fund.find(params[:id])
  end

  def new
    @fund = Fund.new
  end

  def create
    @fund = Fund.new

    @fund.name = params[:name]
    @fund.sponsor_id = params[:sponsor_id]
    @fund.size = params[:size]
    @fund.open = params[:open]
    @fund.open_year = params[:open_year]
    @fund.close_year = params[:close_year]
    @fund.link = params[:link]
    if @fund.link[0..3] = "http" 

    else
      @fund.link "http://" + params[:link]
    end

    if @fund.save
      redirect_to "/funds/#{@fund.id}", :notice => "Fund created successfully."
    else
      render 'new'
    end
  end

  def edit
    @fund = Fund.find(params[:id])
  end

  def update
    @fund = Fund.find(params[:id])

    @fund.name = params[:name]
    @fund.sponsor_id = params[:sponsor_id]
    @fund.size = params[:size]
    @fund.open = params[:open]
    @fund.open_year = params[:open_year]
    @fund.close_year = params[:close_year]
    @fund.link = params[:link]
    if @fund.link[0..3] = "http" 

    else
      @fund.link "http://" + params[:link]
    end
    
    if @fund.save
      redirect_to "/funds/#{@fund.id}", :notice => "Fund updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @fund = Fund.find(params[:id])

    @fund.destroy

    redirect_to "/funds", :notice => "Fund deleted."
  end
  def import
    Fund.import(params[:file])
    redirect_to "/models/", notice: "Funds imported"
  end

end
