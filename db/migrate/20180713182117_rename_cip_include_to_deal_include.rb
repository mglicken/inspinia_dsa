class RenameCipIncludeToDealInclude < ActiveRecord::Migration[5.0]
  def change
  	rename_column :advisor_types, :cip_include, :deal_include
  end
end
