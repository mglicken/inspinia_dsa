class CreateNda < ActiveRecord::Migration[5.0]
  def change
    create_table :ndas do |t|
      t.string :name
      t.integer :deal_id
      t.date :nda_date
      t.string :image_id
    end
  end
end
