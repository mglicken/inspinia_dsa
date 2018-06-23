class CreateLoiHighlight < ActiveRecord::Migration[5.0]
  def change
    create_table :loi_highlights do |t|
      t.integer :loi_id
      t.integer :highlight_id
      t.text :detail
    end
  end
end
