class RemoveCipSponsorId < ActiveRecord::Migration[5.0]
  def change
	remove_column(:diligence_advisors, :cip_sponsor_id)
  end
end
