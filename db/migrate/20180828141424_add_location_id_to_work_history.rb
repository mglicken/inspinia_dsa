class AddLocationIdToWorkHistory < ActiveRecord::Migration[5.0]
  def change
    add_column :work_histories, :location_id, :integer
  end
end
