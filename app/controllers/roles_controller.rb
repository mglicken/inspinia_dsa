class RolesController < ApplicationController
  def index
    @roles = Role.all.order("name ASC")
    respond_to do |format|
      format.html
      format.csv {send_data @roles.to_csv }
    end
  end

  def show
    @role = Role.find(params[:id])
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new


    @role.name = params[:name]

    if @role.save
      redirect_to "/roles", :notice => "Role created successfully."
    else
      render 'new'
    end
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
    @role = Role.find(params[:id])

    @role.name = params[:name]

    if @role.save
      redirect_to "/roles/#{@role.id}/", :notice => "Role updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @role = Role.find(params[:id])

    @role.destroy

    redirect_to "/roles", :notice => "Role deleted."
  end

  def import
    Role.import(params[:file])
    redirect_to "/roles/", notice: "Roles imported"
  end

end
