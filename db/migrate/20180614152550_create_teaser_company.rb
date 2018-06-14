class CreateTeaserCompany < ActiveRecord::Migration[5.0]
  def change
    create_table :teaser_companies do |t|
      t.integer :teaser_id
      t.integer :company_id
      t.integer :nda_id
    end
  end
end
