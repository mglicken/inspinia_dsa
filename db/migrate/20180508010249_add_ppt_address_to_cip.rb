class AddPptAddressToCip < ActiveRecord::Migration
  def change
    add_column :cips, :ppt_address, :string
  end
end
