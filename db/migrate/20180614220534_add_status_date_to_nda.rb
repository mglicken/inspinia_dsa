class AddStatusDateToNda < ActiveRecord::Migration[5.0]
  def change
    add_column :ndas, :status_date, :date
  end
end
