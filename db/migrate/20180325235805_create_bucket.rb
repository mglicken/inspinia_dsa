class CreateBucket < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.integer :nbp_id
      t.string :title
      t.text :rationale
    end
  end
end
