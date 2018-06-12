class AddDealTypeIdToDeal < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :deal_type_id, :integer
  end
end
