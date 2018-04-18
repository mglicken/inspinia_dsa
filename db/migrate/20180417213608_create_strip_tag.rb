class CreateStripTag < ActiveRecord::Migration
  def change
    create_table :strip_tags do |t|
      t.integer :nbp_company_id
      t.integer :tag_id
      t.integer :value
    end
  end
end
