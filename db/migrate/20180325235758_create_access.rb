class CreateAccess < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.string :name
    end
  end
end
