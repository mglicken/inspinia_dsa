class CreateSlideLayoutSlide < ActiveRecord::Migration
  def change
    create_table :slide_layout_slides do |t|
      t.integer :slide_layout_id
      t.integer :slide_id
    end
  end
end
