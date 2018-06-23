class AddLoiIncludeToHighlight < ActiveRecord::Migration[5.0]
  def change
    add_column :highlights, :LoiInclude, :boolean
  end
end
