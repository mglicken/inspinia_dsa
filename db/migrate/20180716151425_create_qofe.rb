class CreateQofe < ActiveRecord::Migration[5.0]
  def change
    create_table :qoves do |t|
      t.string :name
      t.integer :deal_id
      t.date :qofe_date
      t.string :image_id
    end
  end
end
