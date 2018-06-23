class AddIoiIncludeToHighlight < ActiveRecord::Migration[5.0]
  def change
    add_column :highlights, :loiInclude, :boolean
  end
end
