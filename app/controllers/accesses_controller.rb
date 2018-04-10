class AccessesController < ApplicationController

before_action :ensure_admin_access


  def ensure_admin_access
    if current_user.access_id.present?
      if current_user.access_id > 2
        redirect_to root_url, :alert => "Not Authorized"
      end
    end
  end

  def index
    @accesses = Access.all.order("id ASC")

    respond_to do |format|
      format.html
      format.csv {send_data @accesses.to_csv }
    end
  end

  def admin
    
  end

  def download_data

    if params[:id] == 1
      send_data Access.all.to_csv
    elsif params[:id] == 2
      send_data Bucket.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 3
      send_data CaseStudy.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 4
      send_data CaseStudySlide.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 5
      send_data Cip.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 6
      send_data CipSlide.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 7
      send_data Company.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 8
      send_data CompanyFollow.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 9
      send_data CompanyNote.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 10
      send_data Deal.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 11
      send_data DealFollow.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 12
      send_data DealPerson.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 13
      send_data FavoriteSlide.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 14
      send_data Fund.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 15
      send_data FundCompany.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 16
      send_data Mp.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 17
      send_data MpSlide.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 18
      send_data Nbp.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 19
      send_data NbpCompany.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 20
      send_data NbpSlide.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 21
      send_data NbpSponsor.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 22
      send_data Note.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 23
      send_data Person.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 24
      send_data PersonNote.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 25
      send_data Role.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 26
      send_data Slide.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 27
      send_data SlideTag.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 28
      send_data SlideLayout.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 29
      send_data SlideLayoutSlide.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 30
      send_data Sponsor.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 31
      send_data SponsorFollow.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 32
      send_data SponsorHistory.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 33
      send_data SponsorNote.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 34
      send_data Subsidiary.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 35
      send_data Tag.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 36
      send_data Teaser.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 37
      send_data TeaserSlide.all.to_csv
      redirect_to "/download/#{params[:id].to_i + 1}"
    elsif params[:id] == 37
      send_data WorkHistory.all.to_csv
    else
      redirect_to "/models", :notice => "Data Downloaded successfully."
    end
  end

  def show
    @access = Access.find(params[:id])
  end

  def new
    @access = Access.new
  end

  def create
    @access = Access.new


    @access.name = params[:name]

    if @access.save
      redirect_to "/accesses", :notice => "Access created successfully."
    else
      render 'new'
    end
  end

  def edit
    @access = Access.find(params[:id])
  end

  def update
    @access = Access.find(params[:id])

    @access.name = params[:name]

    if @access.save
      redirect_to "/accesses/#{@access.id}/", :notice => "Access updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @access = Access.find(params[:id])

    @access.destroy

    redirect_to "/accesses", :notice => "Access deleted."
  end

  def import
    Access.import(params[:file])
    redirect_to "/models/", notice: "Accesses imported"
  end
end
