class AddPptAddressToCaseStudy < ActiveRecord::Migration
  def change
    add_column :case_studies, :ppt_address, :string
  end
end
