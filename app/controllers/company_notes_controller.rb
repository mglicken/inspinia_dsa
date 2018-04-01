class CompanyNotesController < ApplicationController

before_action :ensure_access

  def ensure_access
    if current_user.access_id.present?
      if current_user.access_id <= 3
        redirect_to root_url, :alert => "Not Authorized"
      end
    end
  end

  def index
    @company_notes = CompanyNote.all

    respond_to do |format|
      format.html
      format.csv {send_data @company_notes.to_csv }
    end
  end

  def show
    @company_note = CompanyNote.find(params[:id])
  end

  def new
    @company_note = CompanyNote.new
  end

  def create
    @company_note = CompanyNote.new

    @company_note.company_id = params[:company_id]
    @company_note.note_id = params[:note_id]
 
    respond_to do |format|
      format.html do
        if @company_note.save
          redirect_to "/notes/#{ params[:note_id] }", :notice => "Company added to note."
        else
          redirect_to "/notes/#{ params[:note_id] }", :notice => "#{@company_note.company.name} already added to this note."
        end
      end
        
      format.js do
        @company_note.save
      end
    end
  end

  def edit
    @company_note = CompanyNote.find(params[:id])
  end

  def update
    @company_note = CompanyNote.find(params[:id])

    @company_note.note_id = params[:note_id]
    @company_note.company_id = params[:company_id]


    if @company_note.save
      redirect_to "/company_notes/#{@company_note.id}/", :notice => "Company Note updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @company_note = CompanyNote.find(params[:id])

    @company_note.destroy

    redirect_to "/company_notes", :notice => "Company Note deleted."
  end

  def import
    CompanyNote.import(params[:file])
    redirect_to "/models/", notice: "Company Notes imported"
  end
end
