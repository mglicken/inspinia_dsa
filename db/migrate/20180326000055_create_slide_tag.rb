class CreateSlideTag < ActiveRecord::Migration
  def change
    create_table :slide_tags do |t|
      t.integer :slide_id
      t.integer :tag_id
    end
  end
end
