class AddFinalBuyerToMpSponsor < ActiveRecord::Migration[5.0]
  def change
    add_column :mp_sponsors, :final_buyer, :boolean
  end
end
