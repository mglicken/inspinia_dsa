class CreateDealFollow < ActiveRecord::Migration
  def change
    create_table :deal_follows do |t|
      t.integer :user_id
      t.integer :deal_id
    end
  end
end
