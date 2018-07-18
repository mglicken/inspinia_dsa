class AddNetSalesTargetToCip < ActiveRecord::Migration[5.0]
  def change
    add_column :cips, :net_sales_target, :float
  end
end
