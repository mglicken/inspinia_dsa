class CreatePerson < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :backwards_name
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.bigint :phone
      t.bigint :cell
      t.string :email_address
      t.string :image_url
      t.boolean :employee
      t.integer :role_id
      t.string :linkedin_url
    end
  end
end
