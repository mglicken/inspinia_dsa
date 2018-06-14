class CreateTeaserSponsor < ActiveRecord::Migration[5.0]
  def change
    create_table :teaser_sponsors do |t|
      t.integer :teaser_id
      t.integer :sponsor_id
      t.integer :nda_id
    end
  end
end
