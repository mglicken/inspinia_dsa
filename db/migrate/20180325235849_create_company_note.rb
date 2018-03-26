class CreateCompanyNote < ActiveRecord::Migration
  def change
    create_table :company_notes do |t|
      t.integer :company_id
      t.integer :note_id
    end
  end
end
