class CreateCompanyFollow < ActiveRecord::Migration
  def change
    create_table :company_follows do |t|
      t.integer :user_id
      t.integer :company_id
    end
  end
end
