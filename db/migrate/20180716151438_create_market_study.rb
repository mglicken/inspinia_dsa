class CreateMarketStudy < ActiveRecord::Migration[5.0]
  def change
    create_table :market_studies do |t|
      t.string :name
      t.integer :deal_id
      t.date :market_study_date
      t.string :image_id
    end
  end
end
