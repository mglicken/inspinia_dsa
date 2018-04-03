class NotesController < ApplicationController

#before_action :ensure_access

  def ensure_access
    if current_user.access_id.present?
      if current_user.access_id > 3
        redirect_to root_url, :alert => "Not Authorized"
      end
    end
  end

  def index
    @notes = Note.all.order("date ASC")

    respond_to do |format|
      format.html
      format.csv {send_data @notes.to_csv }
    end
  end

  def show
    @note = Note.find(params[:id])
  end

  def search
    @text = params[:search].downcase
    note_ids = []
    Note.all.each do |note|
      if note.detail.downcase.include? @text
        note_ids.push(note.id)
      end
    end
    @notes=Note.where(id: note_ids)
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new
    @note.title = params[:title]
    @note.detail = params[:detail]
    if params[:date].present?
      @note.date = params[:date]
    else
      @note.date = Date.current()
    end
    @note.link = params[:link]
    if @note.save
      if params[:company_id] != 0
        company_note = CompanyNote.new
        company_note.company_id = params[:company_id]
        company_note.note_id = @note.id 
        company_note.save
      end
      if params[:person_id] != 0
        person_note = PersonNote.new
        person_note.person_id = params[:person_id]
        person_note.note_id = @note.id 
        person_note.save
      end
      if params[:sponsor_id] != 0
        sponsor_note = SponsorNote.new
        sponsor_note.sponsor_id = params[:sponsor_id]
        sponsor_note.note_id = @note.id
        sponsor_note.save
      end
      redirect_to "/notes/#{@note.id}", :notice => "Note created successfully."
    else
      render 'new'
    end
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])

    @note.title = params[:title]
    @note.detail = params[:detail]
    if params[:date].present?
      @note.date = params[:date]
    else
      @note.date = Date.current()
    end
    @note.link = params[:link]
    if @note.save
      redirect_to "/notes/#{@note.id}/", :notice => "Note updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @note = Note.find(params[:id])

    @note.destroy

    redirect_to "/notes", :notice => "Note deleted."
  end

  def import
    Note.import(params[:file])
    redirect_to "/models/", notice: "Notes imported."
  end
end
