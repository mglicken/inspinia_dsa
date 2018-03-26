class CreateSponsorNote < ActiveRecord::Migration
  def change
    create_table :sponsor_notes do |t|
      t.integer :sponsor_id
      t.integer :note_id
    end
  end
end
