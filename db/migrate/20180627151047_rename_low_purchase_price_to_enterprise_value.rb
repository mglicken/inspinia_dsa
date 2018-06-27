class RenameLowPurchasePriceToEnterpriseValue < ActiveRecord::Migration[5.0]
  def change
  	rename_column :lois, :low_purchase_price, :enterprise_value
  end
end
