class DealPeopleController < ApplicationController

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
    @deal_people = DealPerson.all

    respond_to do |format|
      format.html
      format.csv {send_data @deal_people.to_csv }
    end
  end

  def show
    @deal_people = DealPerson.all
    @deal_person = DealPerson.find(params[:id])
  end

  def new
    @deal_person = DealPerson.new
  end

  def create
    @deal_person = DealPerson.new
    @deal_person.deal_id = params[:deal_id]
    @deal_person.person_id = params[:person_id]
    @deal_person.role_id = @deal_person.person.role_id
 
    respond_to do |format|
      format.html do
        if @deal_person.save
          redirect_to "/deals/#{ params[:deal_id] }", :notice => "Deal Person added successfully."
        else
          render 'new'
        end
      end
        
      format.js do
        @deal_person.save
        render('create.js.erb')
      end

    end
  end

  def edit
    @deal_person = DealPerson.find(params[:id])
  end

  def update
    @deal_person = DealPerson.find(params[:id])

    @deal_person.deal_id = params[:deal_id]
    @deal_person.person_id = params[:person_id]
    @deal_person.role_id = params[:role_id]

    if @deal_person.save
      redirect_to "/deal_people/#{@deal_person.id}/", :notice => "Deal Person updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @deal_person = DealPerson.find(params[:id])
    @deal_person.destroy

    respond_to do |format|
      format.html do
        redirect_to "/deal_people/", :notice => "Deal Person deleted."
      end
      format.js do
        render('destroy.js.erb')
      end
    end
  end

  def import
    DealPerson.import(params[:file])
    redirect_to "/models/", notice: "Deal People imported"
  end
end
