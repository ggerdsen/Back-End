class CreateCourse < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :course_code
      t.string :school_name
      t.references :teacher, foreign_key: true
    end
  end
end
