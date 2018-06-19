class CreateIoi < ActiveRecord::Migration[5.0]
  def change
    create_table :iois do |t|
      t.string :name
      t.integer :deal_id
      t.date :ioi_date
      t.string :image_id
    end
  end
end
