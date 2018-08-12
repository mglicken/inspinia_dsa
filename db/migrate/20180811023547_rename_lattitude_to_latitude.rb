class RenameLattitudeToLatitude < ActiveRecord::Migration[5.0]
  def change
	rename_column :locations, :lattitude, :latitude
  end
end
