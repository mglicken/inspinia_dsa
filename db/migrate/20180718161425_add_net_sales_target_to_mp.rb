class AddNetSalesTargetToMp < ActiveRecord::Migration[5.0]
  def change
    add_column :mps, :net_sales_target, :float
  end
end
