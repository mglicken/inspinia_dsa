class AddLeasedToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :leased, :boolean
  end
end
