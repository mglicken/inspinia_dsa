class CreateLoiSlide < ActiveRecord::Migration[5.0]
  def change
    create_table :loi_slides do |t|
      t.integer :ioi_id
      t.integer :slide_id
      t.string :ppt_address
    end
  end
end
