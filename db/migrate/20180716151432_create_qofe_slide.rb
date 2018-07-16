class CreateQofeSlide < ActiveRecord::Migration[5.0]
  def change
    create_table :qofe_slides do |t|
      t.integer :qofe_id
      t.integer :slide_id
    end
  end
end
