class CreateCipSponsor < ActiveRecord::Migration[5.0]
  def change
    create_table :cip_sponsors do |t|
      t.integer :cip_id
      t.integer :sponsor_id
    end
  end
end
