class CreateCipSlide < ActiveRecord::Migration
  def change
    create_table :cip_slides do |t|
      t.integer :cip_id
      t.integer :slide_id
    end
  end
end
