class CreateDealPerson < ActiveRecord::Migration
  def change
    create_table :deal_people do |t|
      t.integer :deal_id
      t.integer :person_id
      t.integer :role_id
    end
  end
end
