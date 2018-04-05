class SubsidiariesController < ApplicationController

#before_action :ensure_access

  def ensure_access
    if current_user.access_id.present?
      if current_user.access_id > 3
        redirect_to root_url, :alert => "Not Authorized"
      end
    end
  end

  def index
    @subsidiaries = Subsidiary.all

    respond_to do |format|
      format.html
      format.csv {send_data @subsidiaries.to_csv }
    end
  end

  def show
    @subsidiaries = Subsidiary.all
    @subsidiary = Subsidiary.find(params[:id])
  end

  def new
    @subsidiary = Subsidiary.new
  end

  def create
    @subsidiary = Subsidiary.new
    @subsidiary.parent_id = params[:parent_id]
    @subsidiary.child_id = params[:child_id]
    @subsidiary.acquisition_date = params[:acquisition_date]
    @subsidiary.acquisition_price = params[:acquisition_price]
    @subsidiary.link = params[:link]

    @subsidiary.child.children.each do |child|
      if Subsidiary.where(child_id: child.id,parent_id:@subsidiary.parent_id).present?
         subsidiary = Subsidiary.where(child_id: child.id,parent_id:@subsidiary.parent_id).first
         subsidiary.acquisition_date = params[:acquisition_date]
         subsidiary.acquisition_price = params[:acquisition_price]
         subsidiary.link = params[:link]
         subsidiary.save
        else
         subsidiary = Subsidiary.new
         subsidiary.parent_id = params[:parent_id]
         subsidiary.child_id = child.id
         subsidiary.acquisition_date = params[:acquisition_date]
         subsidiary.acquisition_price = params[:acquisition_price]
         subsidiary.link = params[:link]
         subsidiary.save
        end
    end
    
    @subsidiary.parent.parents.each do |parent|
      @subsidiary.parent.children.each do |child|
        if Subsidiary.where(child_id: child.id, parent_id: parent.id).present?
           subsidiary = Subsidiary.where(child_id: child.id,parent_id:@subsidiary.parent_id).first
           subsidiary.acquisition_date = params[:acquisition_date]
           subsidiary.acquisition_price = params[:acquisition_price]
           subsidiary.link = params[:link]
           subsidiary.save
          else
           subsidiary = Subsidiary.new
           subsidiary.parent_id = parent.id
           subsidiary.child_id = child.id
           subsidiary.acquisition_date = params[:acquisition_date]
           subsidiary.acquisition_price = params[:acquisition_price]
           subsidiary.link = params[:link]
           subsidiary.save
          end
      end
    end

 
    respond_to do |format|
      format.html do
        if @subsidiary.save
          redirect_to "/companies/#{ params[:parent_id] }", :notice => "Subsidiary added successfully."
        else
          render 'new'
        end
      end
        
      format.js do
        @subsidiary.save
        render('create.js.erb')
      end
    end
  end

  def edit
    @subsidiary = Subsidiary.find(params[:id])
  end

  def update
    @subsidiary = Subsidiary.find(params[:id])

    @subsidiary = Subsidiary.new
    @subsidiary.parent_id = params[:parent_id]
    @subsidiary.child_id = params[:child_id]
    @subsidiary.acquisition_date = params[:acquisition_date]
    @subsidiary.acquisition_price = params[:acquisition_price]
    @subsidiary.link = params[:link]

    if @subsidiary.save
      redirect_to "/subsidiaries/#{subsidiary.id}/", :notice => "Subsidiary updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @subsidiary = Subsidiary.find(params[:id])
    @subsidiary.destroy

    respond_to do |format|
      format.html do
        redirect_to "/subsidiaries/", :notice => "Subsidiary deleted."
      end
      format.js do
        render('destroy.js.erb')
      end
    end
  end

  def import
    Subsidiary.import(params[:file])
    redirect_to "/models/", notice: "Subsidiaries imported."
  end
end
