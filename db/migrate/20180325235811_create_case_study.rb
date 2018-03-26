class CreateCaseStudy < ActiveRecord::Migration
  def change
    create_table :case_studies do |t|
      t.integer :deal_id
      t.string :image_id
    end
  end
end
