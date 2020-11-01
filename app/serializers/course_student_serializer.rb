class CourseStudentSerializer < BaseSerializer
  attributes :points, :course_id, :student_id
  has_many :course_students
  has_many :courses, through: :course_students
end
