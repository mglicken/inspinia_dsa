class AddNoteToNbpSponsor < ActiveRecord::Migration
  def change
    add_column :nbp_sponsors, :note, :text
  end
end
