class CreateNbp < ActiveRecord::Migration
  def change
    create_table :nbps do |t|
      t.string :name
      t.integer :deal_id
      t.date :nbp_date
      t.string :image_id
    end
  end
end
