class HighlightsController < ApplicationController

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
    @highlights = Highlight.all.order("name ASC")
    respond_to do |format|
      format.html
      format.csv {send_data @highlights.to_csv }
    end
  end

  def show
    @highlight = Highlight.find(params[:id])
  end

  def new
    @highlight = Highlight.new
  end

  def create
    @highlight = Highlight.new


    @highlight.name = params[:name]

    if @highlight.save
      redirect_to "/highlights", :notice => "Highlight created successfully."
    else
      render 'new'
    end
  end

  def edit
    @highlight = Highlight.find(params[:id])
  end

  def update
    @highlight = Highlight.find(params[:id])

    @highlight.name = params[:name]

    if @highlight.save
      redirect_to "/highlights/#{@highlight.id}/", :notice => "Highlight updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @highlight = Highlight.find(params[:id])

    @highlight.destroy

    redirect_to "/highlights", :notice => "Highlight deleted."
  end

  def import
    Highlight.import(params[:file])
    redirect_to "/models/", notice: "Highlights imported"
  end

end
