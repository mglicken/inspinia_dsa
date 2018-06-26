class AddDeclinedToMpSponsor < ActiveRecord::Migration[5.0]
  def change
    add_column :mp_sponsors, :declined, :boolean
  end
end
