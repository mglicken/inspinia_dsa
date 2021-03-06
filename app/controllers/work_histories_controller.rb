class WorkHistoriesController < ApplicationController

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
    @work_histories = WorkHistory.all

    respond_to do |format|
      format.html
      format.csv {send_data @work_histories.to_csv }
    end
  end

  def show
    @work_history = WorkHistory.find(params[:id])
  end

  def new
    @work_history = WorkHistory.new
  end

  def create
    @work_history = WorkHistory.new

    @work_history.person_id = params[:person_id]
    @work_history.company_id = params[:company_id]
    @work_history.location_id = params[:location_id]
    @work_history.role_id = params[:role_id]
    @work_history.current = params[:current]
    @work_history.start_year = params[:start_year]
    @work_history.end_year = params[:end_year]

     respond_to do |format|
      format.html do
        if @work_history.save
          redirect_to "/companies/#{ params[:company_id] }", :notice => "Person added to history."
        else
          redirect_to "/companies/#{ params[:company_id] }", :notice => "#{@work_history.company.name} already added to this history."
        end
      end
        
      format.js do
        @work_history.save
      end
    end
  end

  def edit
    @work_history = WorkHistory.find(params[:id])
  end

  def update
    @work_history = WorkHistory.find(params[:id])


    @work_history.person_id = params[:person_id]
    @work_history.company_id = params[:company_id]
    @work_history.location_id = params[:location_id]
    @work_history.role_id = params[:role_id]
    @work_history.current = params[:current]
    @work_history.start_year = params[:start_year]
    @work_history.end_year = params[:end_year]


    if @work_history.save
      redirect_to "/work_histories/#{@work_history.id}/", :notice => "Work History updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @work_history = WorkHistory.find(params[:id])

    @work_history.destroy

    redirect_to "/work_histories", :notice => "Work History deleted."
  end

  def import
    WorkHistory.import(params[:file])
    redirect_to "/models/", notice: "Work Histories imported"
  end
end
