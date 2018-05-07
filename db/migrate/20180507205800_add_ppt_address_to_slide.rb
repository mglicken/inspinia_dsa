class AddPptAddressToSlide < ActiveRecord::Migration
  def change
    add_column :slides, :ppt_address, :string
  end
end
