class AddDeclinedToMpCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :mp_companies, :declined, :boolean
  end
end
