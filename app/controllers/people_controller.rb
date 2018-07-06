class PeopleController < ApplicationController

before_action :ensure_admin_access,  only: [:models, :index, :access_dashboard, :update_user, :update_access,:destroy, :import]
before_action :ensure_banker_access,  only: [:new, :create, :create_work_history, :create_sponsor_history, :edit, :update, :update_work_history, :update_sponsor_history]
before_action :ensure_view_access,  only: [:user_dashboard, :search, :show]

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

  def models

  end

  def index
    @people = Person.all

    respond_to do |format|
      format.html
      format.csv {send_data @people.to_csv }
    end
  end
  
  def access_dashboard
    @users = User.all.order("id ASC")
    @people=Person.all
  end

  def user_dashboard
    @companies = Company.where(id: CompanyFollow.where(user_id:current_user.id).pluck(:company_id))
    @sponsors = Sponsor.where(id: SponsorFollow.where(user_id:current_user.id).pluck(:sponsor_id))
    @slide_layouts = current_user.slide_layouts.order("id ASC")
    @deals = current_user.person.deals.order("name ASC")
    @notes = current_user.person.notes
  end

   def update_user
    user = User.find(params[:id])
    user.person_id = params[:person_id]
    user.save
    redirect_to root_url, :notice => "User: "+ user.email + " saved as "+user.person.name+"."
   end
   
   def update_access
    user = User.find(params[:id])
    user.access_id = params[:access_id]
    user.save
    redirect_to root_url, :notice => "User: "+ user.person.name + " saved as "+user.access.name+"."
   end

  def search
    @text = params[:search].downcase
    person_ids = []
    Person.all.each do |person|
      if person.name.downcase.include? @text
        person_ids.push(person.id)
      end
    end
    @people=Person.where(id: person_ids)
  end

  def show
    @person = Person.find(params[:id])
    @deals = Deal.where(id: DealPerson.where(deal_id: Nbp.all.order("nbp_date DESC").pluck(:deal_id),person_id: @person.id).pluck(:deal_id).uniq)

  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new

    @person.first_name = params[:first_name]
    @person.last_name = params[:last_name]
    @person.name ="#{@person.first_name} #{@person.last_name}"
    @person.backwards_name ="#{@person.last_name}, #{@person.first_name}" 
    @person.address = params[:address]
    @person.city = params[:city]
    @person.state = params[:state]
    @person.zip = params[:zip]
    @person.phone = params[:phone]
    @person.cell = params[:cell]
    @person.email_address = params[:email_address]
    @person.linkedin_url = params[:linkedin_url]
    @person.employee = params[:employee]
    if params[:image_url] == ""
      @person.image_url="http://res.cloudinary.com/mglicken/image/upload/No_Picture_ouh3db.png" 
    else
      @person.image_url = params[:image_url]
    end
    @person.role_id = params[:role_id]    

    if @person.save
      redirect_to "/people/#{@person.id}", :notice => "Person created successfully."
    else
      render 'new'
    end
  end

  def create_work_history
    @work_history = WorkHistory.new
    @work_history.person_id = params[:person_id]  
    @work_history.company_id = params[:company_id]  
    @work_history.role_id = params[:role_id]  
    @work_history.current = params[:current]
    @work_history.start_year = params[:start_year]
    @work_history.end_year = params[:end_year]

    if @work_history.save
      redirect_to "/people/#{@work_history.person_id}", :notice => "Work history added successfully."
    else
      render 'new'
    end
  end

  def update_work_history
    @work_history = WorkHistory.find(params[:id])
    @work_history.person_id = params[:person_id]  
    @work_history.company_id = params[:company_id]  
    @work_history.role_id = params[:role_id]  
    @work_history.current = params[:current]
    @work_history.start_year = params[:start_year]
    @work_history.end_year = params[:end_year]

    if @work_history.save
      redirect_to "/people/#{@work_history.person_id}", :notice => "Work history updates successfully."
    else
      render 'new'
    end
  end

  def create_sponsor_history
    @sponsor_history = SponsorHistory.new
    @sponsor_history.person_id = params[:person_id]  
    @sponsor_history.sponsor_id = params[:sponsor_id]  
    @sponsor_history.role_id = params[:role_id]  
    @sponsor_history.current = params[:current]
    @sponsor_history.start_year = params[:start_year]
    @sponsor_history.end_year = params[:end_year]

    if @sponsor_history.save
      redirect_to "/people/#{@sponsor_history.person_id}", :notice => "Sponsor history added successfully."
    else
      render 'new'
    end
  end

  def update_sponsor_history
    @sponsor_history = SponsorHistory.find(params[:id])
    @sponsor_history.person_id = params[:person_id]  
    @sponsor_history.sponsor_id = params[:sponsor_id]  
    @sponsor_history.role_id = params[:role_id]  
    @sponsor_history.current = params[:current]
    @sponsor_history.start_year = params[:start_year]
    @sponsor_history.end_year = params[:end_year]

    if @sponsor_history.save
      redirect_to "/people/#{@sponsor_history.person_id}", :notice => "Sponsor history updates successfully."
    else
      render 'new'
    end
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])

    @person.first_name = params[:first_name]
    @person.last_name = params[:last_name]
    @person.name ="#{@person.first_name} #{@person.last_name}"
    @person.backwards_name ="#{@person.last_name}, #{@person.first_name}" 
    @person.address = params[:address]
    @person.city = params[:city]
    @person.state = params[:state]
    @person.zip = params[:zip]
    @person.phone = params[:phone]
    @person.cell = params[:cell]    
    @person.email_address = params[:email_address]
    @person.linkedin_url = params[:linkedin_url]
    @person.employee = params[:employee]
    @person.role_id = params[:role_id]
    if params[:image_url] == ""
      @person.image_url="http://res.cloudinary.com/mglicken/image/upload/No_Picture_ouh3db.png" 
    else
      @person.image_url = params[:image_url]
    end 
    
    if @person.save
      redirect_to "/people/#{@person.id}", :notice => "Person updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @person = Person.find(params[:id])

    @person.destroy

    redirect_to "/people", :notice => "Deal deleted."
  end
  def import
    Person.import(params[:file])
    redirect_to "/models/", notice: "People imported"
  end
end
