class CreateCompany < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.float :revenue
      t.float :ebitda
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.bigint :phone
      t.string :web_address
      t.text :description
      t.date :description_date
      t.string :linkedin_url
      t.string :quote
    end
  end
end
