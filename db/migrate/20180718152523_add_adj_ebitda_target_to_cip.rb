class AddAdjEbitdaTargetToCip < ActiveRecord::Migration[5.0]
  def change
    add_column :cips, :adj_ebitda_target, :float
  end
end
