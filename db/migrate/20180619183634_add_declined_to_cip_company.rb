class AddDeclinedToCipCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :cip_companies, :declined, :boolean
  end
end
