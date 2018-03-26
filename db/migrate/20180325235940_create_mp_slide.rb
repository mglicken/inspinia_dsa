class CreateMpSlide < ActiveRecord::Migration
  def change
    create_table :mp_slides do |t|
      t.integer :mp_id
      t.integer :slide_id
    end
  end
end
