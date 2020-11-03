class TeacherCourseSerializer < BaseSerializer
  attributes :name, :course_code, :school_name, :course_points, :teacher_id
  has_many :students, through: :course_students
end
