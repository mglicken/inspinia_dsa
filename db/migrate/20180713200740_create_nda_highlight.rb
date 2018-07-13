class CreateNdaHighlight < ActiveRecord::Migration[5.0]
  def change
    create_table :nda_highlights do |t|
      t.integer :nda_id
      t.integer :highlight_id
      t.text :detail
    end
  end
end
