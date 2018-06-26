class CreateDiligenceAdvisor < ActiveRecord::Migration[5.0]
  def change
    create_table :diligence_advisors do |t|
      t.integer :mp_sponsor_id
      t.integer :mp_company_id
      t.integer :cip_sponsor_id
      t.integer :cip_company_id
      t.integer :person_id
      t.integer :company_id
      t.integer :advisor_type_id
    end
  end
end
