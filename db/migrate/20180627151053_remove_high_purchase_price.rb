class RemoveHighPurchasePrice < ActiveRecord::Migration[5.0]
  def change
	remove_column(:lois, :high_purchase_price)
  end
end
