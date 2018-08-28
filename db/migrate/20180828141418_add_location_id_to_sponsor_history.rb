class AddLocationIdToSponsorHistory < ActiveRecord::Migration[5.0]
  def change
    add_column :sponsor_histories, :location_id, :integer
  end
end
