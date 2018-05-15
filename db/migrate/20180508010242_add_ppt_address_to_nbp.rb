class AddPptAddressToNbp < ActiveRecord::Migration
  def change
    add_column :nbps, :ppt_address, :string
  end
end
