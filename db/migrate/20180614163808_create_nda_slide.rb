class CreateNdaSlide < ActiveRecord::Migration[5.0]
  def change
    create_table :nda_slides do |t|
      t.integer :nda_id
      t.integer :slide_id
      t.string :ppt_address
    end
  end
end
