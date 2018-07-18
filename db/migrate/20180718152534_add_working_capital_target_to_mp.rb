class AddWorkingCapitalTargetToMp < ActiveRecord::Migration[5.0]
  def change
    add_column :mps, :working_capital_target, :float
  end
end
