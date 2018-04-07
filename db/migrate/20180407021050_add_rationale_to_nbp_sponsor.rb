class AddRationaleToNbpSponsor < ActiveRecord::Migration
  def change
    add_column :nbp_sponsors, :rationale, :text
  end
end
