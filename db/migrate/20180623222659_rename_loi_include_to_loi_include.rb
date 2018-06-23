class RenameLoiIncludeToLoiInclude < ActiveRecord::Migration[5.0]
  def change
  	rename_column :highlights, :LoiInclude, :loi_include
  end
end
