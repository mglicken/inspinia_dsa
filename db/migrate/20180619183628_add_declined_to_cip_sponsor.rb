class AddDeclinedToCipSponsor < ActiveRecord::Migration[5.0]
  def change
    add_column :cip_sponsors, :declined, :boolean
  end
end
