class UpdatePointsToStudentPoints < ActiveRecord::Migration[5.2]
  def change
    rename_column :course_students, :points, :student_points
  end
end
