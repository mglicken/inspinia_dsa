class AddMpDateToMpSponsor < ActiveRecord::Migration[5.0]
  def change
    add_column :mp_sponsors, :mp_date, :date
  end
end
