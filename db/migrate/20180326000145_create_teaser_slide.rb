class CreateTeaserSlide < ActiveRecord::Migration
  def change
    create_table :teaser_slides do |t|
      t.integer :teaser_id
      t.integer :slide_id
    end
  end
end
