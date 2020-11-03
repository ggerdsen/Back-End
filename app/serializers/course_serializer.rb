class CourseSerializer < BaseSerializer
  attributes :teacher_id, :name, :course_code, :school_name, :course_points
  has_many :students, through: :course_students
  belongs_to :teacher
end
