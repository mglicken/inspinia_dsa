class CreateCipCompany < ActiveRecord::Migration[5.0]
  def change
    create_table :cip_companies do |t|
      t.integer :cip_id
      t.integer :company_id
    end
  end
end
