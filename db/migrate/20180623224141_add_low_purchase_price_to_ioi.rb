class AddLowPurchasePriceToIoi < ActiveRecord::Migration[5.0]
  def change
    add_column :iois, :low_purchase_price, :float
  end
end
