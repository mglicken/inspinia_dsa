class CreateTeaser < ActiveRecord::Migration
  def change
    create_table :teasers do |t|
      t.string :name
      t.integer :deal_id
      t.date :teaser_date
      t.string :image_id
    end
  end
end
