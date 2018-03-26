class CreateSlideLayout < ActiveRecord::Migration
  def change
    create_table :slide_layouts do |t|
      t.string :name
      t.integer :user_id
      t.integer :deal_id
      t.date :date
    end
  end
end
