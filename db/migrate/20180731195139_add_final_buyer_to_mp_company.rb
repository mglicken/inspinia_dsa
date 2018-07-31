class AddFinalBuyerToMpCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :mp_companies, :final_buyer, :boolean
  end
end
