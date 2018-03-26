class AddAccessIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :access_id, :integer
  end
end
