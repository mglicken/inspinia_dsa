class AddNdaIncludeToHighlight < ActiveRecord::Migration[5.0]
  def change
    add_column :highlights, :nda_include, :boolean
  end
end
