class CourseSerializer < BaseSerializer
  attributes :name, :course_code
  has_many :students, through: :course_students
end
