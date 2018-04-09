class PersonNotesController < ApplicationController

before_action :ensure_access

  def ensure_access
    if current_user.access_id.present?
      if current_user.access_id > 3
        redirect_to root_url, :alert => "Not Authorized"
      end
    end
  end
  
  def index
    @person_notes = PersonNote.all

    respond_to do |format|
      format.html
      format.csv {send_data @person_notes.to_csv }
    end
  end

  def show
    @person_note = PersonNote.find(params[:id])
  end

  def new
    @person_note = PersonNote.new
  end

  def create
    @person_note = PersonNote.new

    @person_note.person_id = params[:person_id]
    @person_note.note_id = params[:note_id]
 
    respond_to do |format|
      format.html do
        if @person_note.save
          redirect_to "/notes/#{ params[:note_id] }", :notice => "Person added to note."
        else
          redirect_to "/notes/#{ params[:note_id] }", :notice => "#{@person_note.person.name} already added to this note."
        end
      end
        
      format.js do
        @person_note.save
      end
    end
  end

  def edit
    @person_note = PersonNote.find(params[:id])
  end

  def update
    @person_note = PersonNote.find(params[:id])

    @person_note.note_id = params[:note_id]
    @person_note.person_id = params[:person_id]


    if @person_note.save
      redirect_to "/person_notes/#{@person_note.id}/", :notice => "Person Note updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @person_note = PersonNote.find(params[:id])

    @person_note.destroy

    redirect_to "/person_notes", :notice => "Person Note deleted."
  end

  def import
    PersonNote.import(params[:file])
    redirect_to "/models/", notice: "Person Notes imported"
  end
end
