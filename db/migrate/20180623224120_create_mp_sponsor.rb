class CreateMpSponsor < ActiveRecord::Migration[5.0]
  def change
    create_table :mp_sponsors do |t|
      t.integer :mp_id
      t.integer :sponsor_id
      t.integer :loi_id
    end
  end
end
