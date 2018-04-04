class AddNameToCaseStudy < ActiveRecord::Migration
  def change
    add_column :case_studies, :name, :string
  end
end
