class CreateWorkHistory < ActiveRecord::Migration
  def change
    create_table :work_histories do |t|
      t.integer :person_id
      t.integer :company_id
      t.integer :role_id
      t.boolean :current
      t.integer :start_year
      t.integer :end_year
    end
  end
end
