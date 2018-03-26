class CreateNbpSlide < ActiveRecord::Migration
  def change
    create_table :nbp_slides do |t|
      t.integer :nbp_id
      t.integer :slide_id
    end
  end
end
