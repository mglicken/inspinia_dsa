class AddIoiIdToCipSponsor < ActiveRecord::Migration[5.0]
  def change
    add_column :cip_sponsors, :ioi_id, :integer
  end
end
