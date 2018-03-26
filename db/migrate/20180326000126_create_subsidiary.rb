class CreateSubsidiary < ActiveRecord::Migration
  def change
    create_table :subsidiaries do |t|
      t.integer :parent_id
      t.integer :child_id
      t.date :acquisition_date
      t.float :acquisition_price
      t.string :link
    end
  end
end
