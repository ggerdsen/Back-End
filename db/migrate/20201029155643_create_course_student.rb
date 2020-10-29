class CreateCourseStudent < ActiveRecord::Migration[5.2]
  def change
    create_table :course_students do |t|
      t.references :course, foreign_key: true
      t.references :student, foreign_key: true
      t.integer :points
    end
  end
end
