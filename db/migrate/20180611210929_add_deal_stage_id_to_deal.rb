class AddDealStageIdToDeal < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :deal_stage_id, :integer
  end
end
