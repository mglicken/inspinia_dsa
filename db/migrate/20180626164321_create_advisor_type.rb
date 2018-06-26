class CreateAdvisorType < ActiveRecord::Migration[5.0]
  def change
    create_table :advisor_types do |t|
      t.string :name
      t.boolean :mp_include
      t.boolean :cip_include
    end
  end
end
