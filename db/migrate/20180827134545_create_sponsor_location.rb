class CreateSponsorLocation < ActiveRecord::Migration[5.0]
  def change
    create_table :sponsor_locations do |t|
      t.integer :sponsor_id
      t.integer :location_id
    end
  end
end
