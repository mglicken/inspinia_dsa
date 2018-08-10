class AddLattitudeToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :lattitude, :float
  end
end
