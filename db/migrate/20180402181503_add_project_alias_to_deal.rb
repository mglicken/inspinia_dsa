class AddProjectAliasToDeal < ActiveRecord::Migration
  def change
    add_column :deals, :project_alias, :string
  end
end
