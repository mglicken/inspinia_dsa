class CreatePersonNote < ActiveRecord::Migration
  def change
    create_table :person_notes do |t|
      t.integer :person_id
      t.integer :note_id
    end
  end
end
