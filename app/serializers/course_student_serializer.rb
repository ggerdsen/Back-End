class CourseStudentSerializer < BaseSerializer
  attributes :id, :student_points, :course_id, :student_id
  belongs_to :course
  belongs_to :student
end
