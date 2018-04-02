class AddProjectCodeToDeal < ActiveRecord::Migration
  def change
    add_column :deals, :project_code, :integer
  end
end
