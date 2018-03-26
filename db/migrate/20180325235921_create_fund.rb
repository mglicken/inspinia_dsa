class CreateFund < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.integer :sponsor_id
      t.string :name
      t.float :size
      t.boolean :open
      t.integer :open_year
      t.integer :close_year
      t.string :link
    end
  end
end
