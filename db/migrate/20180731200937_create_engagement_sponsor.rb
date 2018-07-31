class CreateEngagementSponsor < ActiveRecord::Migration[5.0]
  def change
    create_table :engagement_sponsors do |t|
      t.integer :sponsor_id
      t.integer :deal_id
    end
  end
end
