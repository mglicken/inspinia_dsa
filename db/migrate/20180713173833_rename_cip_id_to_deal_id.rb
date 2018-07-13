class RenameCipIdToDealId < ActiveRecord::Migration[5.0]
  def change
  	rename_column :diligence_advisors, :cip_id, :deal_id
  end
end
