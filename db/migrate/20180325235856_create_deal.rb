class CreateDeal < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :name
      t.integer :company_id
    end
  end
end
