class CreatePrizes < ActiveRecord::Migration[5.2]
  def change
    create_table :prizes do |t|
      t.string :name
      t.integer :prize_points
    end
  end
end
