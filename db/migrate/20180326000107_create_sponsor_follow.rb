class CreateSponsorFollow < ActiveRecord::Migration
  def change
    create_table :sponsor_follows do |t|
      t.integer :sponsor_id
      t.integer :user_id
    end
  end
end
