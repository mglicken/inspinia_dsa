class RenameCipCompanyIdToCipId < ActiveRecord::Migration[5.0]
  def change
  	rename_column :diligence_advisors, :cip_company_id, :cip_id
  end
end
