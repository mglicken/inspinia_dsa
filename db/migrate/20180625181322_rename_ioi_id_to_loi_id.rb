class RenameIoiIdToLoiId < ActiveRecord::Migration[5.0]
  def change
  	rename_column :loi_slides, :ioi_id, :loi_id
  end
end
