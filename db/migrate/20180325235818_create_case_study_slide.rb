class CreateCaseStudySlide < ActiveRecord::Migration
  def change
    create_table :case_study_slides do |t|
      t.integer :case_study_id
      t.integer :slide_id
    end
  end
end
