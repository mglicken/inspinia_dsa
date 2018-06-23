class AddHighPurchasePriceToIoi < ActiveRecord::Migration[5.0]
  def change
    add_column :iois, :high_purchase_price, :float
  end
end
