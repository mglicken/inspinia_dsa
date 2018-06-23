class RenameIoiIncludeToIoiInclude < ActiveRecord::Migration[5.0]
  def change
  	rename_column :highlights, :loiInclude, :ioi_include
  end
end
