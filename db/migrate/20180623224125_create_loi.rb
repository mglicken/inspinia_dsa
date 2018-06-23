class CreateLoi < ActiveRecord::Migration[5.0]
  def change
    create_table :lois do |t|
      t.string :name
      t.integer :deal_id
      t.date :loi_date
      t.string :image_id
      t.float :low_purchase_price
      t.float :high_purchase_price
    end
  end
end
