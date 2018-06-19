class RenameHighlightIdToHighlightId < ActiveRecord::Migration[5.0]
  def change
  	rename_column :ioi_highlights, :Highlight_id, :highlight_id
  end
end
