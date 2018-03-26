class SponsorNotesController < ApplicationController
  def index
    @sponsor_notes = SponsorNote.all

    respond_to do |format|
      format.html
      format.csv {send_data @sponsor_notes.to_csv }
    end
  end

  def show
    @sponsor_note = SponsorNote.find(params[:id])
  end

  def new
    @sponsor_note = SponsorNote.new
  end

  def create
    @sponsor_note = SponsorNote.new

    @sponsor_note.sponsor_id = params[:sponsor_id]
    @sponsor_note.note_id = params[:note_id]
 
    respond_to do |format|
      format.html do
        if @sponsor_note.save
          redirect_to "/notes/#{ params[:note_id] }", :notice => "Sponsor added to note."
        else
          redirect_to "/notes/#{ params[:note_id] }", :notice => "#{@sponsor_note.sponsor.name} already added to this note."
        end
      end
        
      format.js do
        @sponsor_note.save
      end
    end
  end

  def edit
    @sponsor_note = SponsorNote.find(params[:id])
  end

  def update
    @sponsor_note = SponsorNote.find(params[:id])

    @sponsor_note.note_id = params[:note_id]
    @sponsor_note.sponsor_id = params[:sponsor_id]


    if @sponsor_note.save
      redirect_to "/sponsor_notes/#{@sponsor_note.id}/", :notice => "Sponsor Note updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @sponsor_note = SponsorNote.find(params[:id])

    @sponsor_note.destroy

    redirect_to "/sponsor_notes", :notice => "Sponsor Note deleted."
  end

  def import
    SponsorNote.import(params[:file])
    redirect_to "/sponsor_notes/", notice: "Sponsor Notes imported"
  end
end
