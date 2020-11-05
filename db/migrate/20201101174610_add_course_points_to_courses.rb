class AddCoursePointsToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :course_points, :integer
  end
end
