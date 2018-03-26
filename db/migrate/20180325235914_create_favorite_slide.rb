class CreateFavoriteSlide < ActiveRecord::Migration
  def change
    create_table :favorite_slides do |t|
      t.integer :user_id
      t.integer :slide_id
    end
  end
end
