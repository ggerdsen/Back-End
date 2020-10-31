class TeacherCourseSerializer < BaseSerializer
  attributes :name, :course_code, :school_name
  has_many :students, through: :course_students
end
