class StudentSerializer < BaseSerializer
  attributes :name
  has_many :courses, through: :course_students
end
