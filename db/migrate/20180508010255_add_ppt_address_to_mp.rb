class AddPptAddressToMp < ActiveRecord::Migration
  def change
    add_column :mps, :ppt_address, :string
  end
end
