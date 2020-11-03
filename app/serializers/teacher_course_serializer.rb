class TeacherCourseSerializer < BaseSerializer
  attributes :name, :course_code, :school_name
  belongs_to :teacher
  has_many :students, through: :course_students
  
  attribute :students do |course|
    StudentSerializer.new(course.students)
  end
end
