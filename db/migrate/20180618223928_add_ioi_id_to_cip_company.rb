class AddIoiIdToCipCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :cip_companies, :ioi_id, :integer
  end
end
