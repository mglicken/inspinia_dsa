class AddNdaIncludeToAdvisorType < ActiveRecord::Migration[5.0]
  def change
    add_column :advisor_types, :nda_include, :boolean
  end
end
