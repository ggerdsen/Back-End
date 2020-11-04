class CreateWars < ActiveRecord::Migration[5.2]
  def change
    create_table :wars do |t|
      t.integer :challenger_course_id
      t.integer :opponent_course_id
      t.integer :challenger_course_points
      t.integer :opponent_course_points
      t.references :teacher, foreign_key: true
    end
  end
end
