class CreateIoiHighlight < ActiveRecord::Migration[5.0]
  def change
    create_table :ioi_highlights do |t|
      t.integer :ioi_id
      t.integer :Highlight_id
      t.text :detail
    end
  end
end
