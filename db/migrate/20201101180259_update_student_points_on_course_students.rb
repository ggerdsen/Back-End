class UpdateStudentPointsOnCourseStudents < ActiveRecord::Migration[5.2]
  def change
    change_column :course_students, :student_points, :integer, default: 0
  end
end
