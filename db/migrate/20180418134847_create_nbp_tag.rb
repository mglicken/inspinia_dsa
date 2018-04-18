class CreateNbpTag < ActiveRecord::Migration
  def change
    create_table :nbp_tags do |t|
      t.integer :nbp_id
      t.integer :tag_id
    end
  end
end
