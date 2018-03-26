class CreateCip < ActiveRecord::Migration
  def change
    create_table :cips do |t|
      t.string :name
      t.integer :deal_id
      t.date :cip_date
      t.string :image_id
    end
  end
end
