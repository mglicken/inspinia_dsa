class CreateMarketStudySlide < ActiveRecord::Migration[5.0]
  def change
    create_table :market_study_slides do |t|
      t.integer :market_study_id
      t.integer :slide_id
    end
  end
end
