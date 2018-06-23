class CreateMpCompany < ActiveRecord::Migration[5.0]
  def change
    create_table :mp_companies do |t|
      t.integer :mp_id
      t.integer :company_id
      t.integer :loi_id
    end
  end
end
