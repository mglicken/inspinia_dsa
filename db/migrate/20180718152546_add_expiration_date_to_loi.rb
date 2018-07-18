class AddExpirationDateToLoi < ActiveRecord::Migration[5.0]
  def change
    add_column :lois, :expiration_date, :date
  end
end
