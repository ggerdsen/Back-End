class ChangeCourseCodeToString < ActiveRecord::Migration[5.2]
  def change
    change_column :courses, :course_code, :string
  end
end
