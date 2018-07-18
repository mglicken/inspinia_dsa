class AddAdjEbitdaTargetToMp < ActiveRecord::Migration[5.0]
  def change
    add_column :mps, :adj_ebitda_target, :float
  end
end
