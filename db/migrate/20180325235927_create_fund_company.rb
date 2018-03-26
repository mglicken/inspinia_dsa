class CreateFundCompany < ActiveRecord::Migration
  def change
    create_table :fund_companies do |t|
      t.integer :fund_id
      t.integer :company_id
      t.date :acquisition_date
      t.float :acquisition_price
      t.string :link
    end
  end
end
