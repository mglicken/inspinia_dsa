class RenameAddressToStreet < ActiveRecord::Migration[5.0]
  def change
  	rename_column :locations, :address, :street
  end
end
