class AddPptAddressToTeaser < ActiveRecord::Migration
  def change
    add_column :teasers, :ppt_address, :string
  end
end
