class SponsorHistoriesController < ApplicationController

before_action :ensure_admin_access,  only: [:index, :import]
before_action :ensure_banker_access,  only: [:show, :new, :create, :edit, :update, :destroy]

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
    @sponsor_histories = SponsorHistory.all

    respond_to do |format|
      format.html
      format.csv {send_data @sponsor_histories.to_csv }
    end
  end

  def show
    @sponsor_history = SponsorHistory.find(params[:id])
  end

  def new
    @sponsor_history = SponsorHistory.new
  end

  def create
    @sponsor_history = SponsorHistory.new

    @sponsor_history.person_id = params[:person_id]
    @sponsor_history.sponsor_id = params[:sponsor_id]
    @sponsor_history.location_id = params[:location_id]
    @sponsor_history.role_id = params[:role_id]
    @sponsor_history.current = params[:current]
    @sponsor_history.start_year = params[:start_year]
    @sponsor_history.end_year = params[:end_year]

     respond_to do |format|
      format.html do
        if @sponsor_history.save
          redirect_to "/sponsors/#{ params[:sponsor_id] }", :notice => "Person added to history."
        else
          redirect_to "/sponsors/#{ params[:sponsor_id] }", :notice => "#{@sponsor_history.sponsor.name} already added to this history."
        end
      end
        
      format.js do
        @sponsor_history.save
      end
    end
  end

  def edit
    @sponsor_history = SponsorHistory.find(params[:id])
  end

  def update
    @sponsor_history = SponsorHistory.find(params[:id])


    @sponsor_history.person_id = params[:person_id]
    @sponsor_history.sponsor_id = params[:sponsor_id]
    @sponsor_history.location_id = params[:location_id]
    @sponsor_history.role_id = params[:role_id]
    @sponsor_history.current = params[:current]
    @sponsor_history.start_year = params[:start_year]
    @sponsor_history.end_year = params[:end_year]


    if @sponsor_history.save
      redirect_to "/sponsor_histories/#{@sponsor_history.id}/", :notice => "Sponsor History updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @sponsor_history = SponsorHistory.find(params[:id])

    @sponsor_history.destroy

    redirect_to "/sponsor_histories", :notice => "Sponsor History deleted."
  end

  def import
    SponsorHistory.import(params[:file])
    redirect_to "/models/", notice: "Sponsor Histories imported"
  end
end
