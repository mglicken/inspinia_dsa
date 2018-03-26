class CreateMp < ActiveRecord::Migration
  def change
    create_table :mps do |t|
      t.string :name
      t.integer :deal_id
      t.date :mp_date
      t.string :image_id
    end
  end
end
