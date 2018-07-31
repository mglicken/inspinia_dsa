class CreateEngagementCompany < ActiveRecord::Migration[5.0]
  def change
    create_table :engagement_companies do |t|
      t.integer :company_id
      t.integer :deal_id
    end
  end
end
