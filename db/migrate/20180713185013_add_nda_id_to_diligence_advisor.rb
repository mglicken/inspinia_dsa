class AddNdaIdToDiligenceAdvisor < ActiveRecord::Migration[5.0]
  def change
    add_column :diligence_advisors, :nda_id, :integer
  end
end
