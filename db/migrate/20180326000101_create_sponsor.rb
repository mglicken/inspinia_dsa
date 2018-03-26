class CreateSponsor < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :name
      t.string :tier
      t.string :sponsor_type
      t.integer :rco_id
      t.integer :co_id
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.bigint :phone
      t.string :web_address
      t.text :description
      t.date :description_date
      t.string :linkedin_url
    end
  end
end
