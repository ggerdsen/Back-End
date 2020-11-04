class UpdateCoursePointsOnCourses < ActiveRecord::Migration[5.2]
  def change
    change_column :courses, :course_points, :integer, default: 0
  end
end
