class AddWorkingCapitalTargetToLoi < ActiveRecord::Migration[5.0]
  def change
    add_column :lois, :working_capital_target, :float
  end
end
