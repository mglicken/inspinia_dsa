class CreateNote < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title
      t.text :detail
      t.date :date
      t.string :link
    end
  end
end
