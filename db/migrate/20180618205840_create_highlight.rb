class CreateHighlight < ActiveRecord::Migration[5.0]
  def change
    create_table :highlights do |t|
      t.string :name
    end
  end
end
