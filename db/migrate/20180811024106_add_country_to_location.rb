class AddCountryToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :country, :string
  end
end
