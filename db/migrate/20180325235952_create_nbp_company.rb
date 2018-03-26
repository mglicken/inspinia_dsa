class CreateNbpCompany < ActiveRecord::Migration
  def change
    create_table :nbp_companies do |t|
      t.integer :nbp_id
      t.integer :company_id
      t.integer :bucket_id
      t.integer :tier_id
      t.boolean :include_strip
      t.text :strip
      t.text :note
    end
  end
end
