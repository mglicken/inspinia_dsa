class CreateDealStage < ActiveRecord::Migration[5.0]
  def change
    create_table :deal_stages do |t|
      t.string :name
    end
  end
end
