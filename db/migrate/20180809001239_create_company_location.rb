class CreateCompanyLocation < ActiveRecord::Migration[5.0]
  def change
    create_table :company_locations do |t|
      t.integer :company_id
      t.integer :location_id
    end
  end
end
