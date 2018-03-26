class CreateNbpSponsor < ActiveRecord::Migration
  def change
    create_table :nbp_sponsors do |t|
      t.integer :nbp_id
      t.integer :sponsor_id
      t.boolean :featured
    end
  end
end
