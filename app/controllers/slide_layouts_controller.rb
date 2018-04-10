class SlideLayoutsController < ApplicationController

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
    @slide_layouts = SlideLayout.all

    respond_to do |format|
      format.html
      format.csv {send_data @slide_layouts.to_csv }
    end
  end


  def show
    @slide_layout = SlideLayout.find(params[:id])
    @favorite_slides = current_user.favorite_slides
  end

  def new
    @slide_layout = SlideLayout.new
  end
 
  def create
    @slide_layout = SlideLayout.new
    @slide_ids = params[:slide_ids].split(",").map { |s| s.to_i }

    @slide_layout.name = params[:name]
    if @slide_layout.name == "" || @slide_layout.name.nil?
     redirect_to "/favorite_slides", :alert => "Slide Layout must have a name."      
    else
      @slide_layout.date = params[:date]
      @slide_layout.user_id = params[:user_id]
      @slide_layout.deal_id = params[:deal_id]
      
      if @slide_layout.save

      @slide_ids.each do |slide_id|
        sls = SlideLayoutSlide.new
        sls.slide_layout_id = @slide_layout.id
        sls.slide_id = slide_id
        sls.save
      end
        redirect_to "/slide_layouts/#{@slide_layout.id}", :notice => "Slide Layout created successfully."
      else
        render 'new'
      end
    end
  end

  def share_layout

    @slide_layout1 = SlideLayout.find(params[:slide_layout_id])
    @slide_layout2 = SlideLayout.new
    @user = Person.find(params[:person_id]).users.last
    if @user.nil?
      redirect_to "/slide_layout/#{@slide_layout1.id}", :alert => "Person does not have a user account. Layout cannot be shared."
    else
      @slide_layout2.name = @slide_layout1.name + " (#{current_user.person.name})"
      @slide_layout2.date = Date.today
      @slide_layout2.user_id = @user.id
      @slide_layout2.deal_id = @slide_layout1.deal_id
      if @slide_layout2.save

        @slide_layout1.slides.each do |slide|
          sls = SlideLayoutSlide.new
          sls.slide_layout_id = @slide_layout2.id
          sls.slide_id = slide.id
          sls.save
        end

        redirect_to "/slide_layouts/#{@slide_layout1.id}", :notice => "Slide Layout shared with #{@user.person.name} successfully."
      else
        render 'new'
      end

    end
  end


  def edit
    @slide_layout = SlideLayout.find(params[:id])
  end

  def update
    @slide_layout = SlideLayout.find(params[:id])

    @slide_ids = params[:slide_ids].split(",").map { |s| s.to_i }

    @slide_layout.name = params[:name]
    @slide_layout.date = params[:date]
    @slide_layout.user_id = params[:user_id]
    @slide_layout.deal_id = params[:deal_id]
    slide_number = 0
    if @slide_ids.count > @slide_layout.slides.count
      @slide_ids.each do |slide_id|
        if slide_number <= (@slide_layout.slides.count-1)
          sls = @slide_layout.slide_layout_slides[slide_number]
          sls.slide_id = slide_id
          sls.save
          slide_number = slide_number + 1
        else
          sls = SlideLayoutSlide.new
          sls.slide_layout_id = @slide_layout.id
          sls.slide_id = slide_id
          sls.save
          slide_number = slide_number + 1
        end
      end
    else
      @slide_layout.slide_layout_slides.each do |sls|
        if slide_number <= (@slide_ids.count-1)
          sls.slide_id = @slide_ids[slide_number]
          sls.save
          slide_number = slide_number + 1
        else
          sls.destroy
          slide_number = slide_number + 1
        end
      end
    end

    if @slide_layout.save
      redirect_to "/slide_layouts/#{@slide_layout.id}", :notice => "Slide Layout updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @slide_layout = SlideLayout.find(params[:id])

    @slide_layout.destroy

    redirect_to "/", :notice => "Slide Layout deleted."
  end

  def import
    SlideLayout.import(params[:file])
    redirect_to "/models/", notice: "Slide Layouts imported."
  end
end
