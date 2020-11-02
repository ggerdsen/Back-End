class CourseSerializer < BaseSerializer
  attributes :name, :teacher_id, :course_points
  has_many :course_students
  has_many :students, through: :course_students
end
