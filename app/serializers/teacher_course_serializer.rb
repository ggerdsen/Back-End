class TeacherCourseSerializer < BaseSerializer
  attributes :name, :course_code
  has_many :students, through: :course_students
end
