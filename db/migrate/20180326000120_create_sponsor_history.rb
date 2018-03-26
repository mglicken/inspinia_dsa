class CreateSponsorHistory < ActiveRecord::Migration
  def change
    create_table :sponsor_histories do |t|
      t.integer :person_id
      t.integer :sponsor_id
      t.integer :role_id
      t.boolean :current
      t.integer :start_year
      t.integer :end_year
    end
  end
end
