class CreateSlide < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.integer :number
      t.string :image_url
    end
  end
end
