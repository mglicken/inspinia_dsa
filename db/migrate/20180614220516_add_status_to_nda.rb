class AddStatusToNda < ActiveRecord::Migration[5.0]
  def change
    add_column :ndas, :status, :integer
  end
end
