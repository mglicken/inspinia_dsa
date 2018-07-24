class AddMpDateToMpCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :mp_companies, :mp_date, :date
  end
end
