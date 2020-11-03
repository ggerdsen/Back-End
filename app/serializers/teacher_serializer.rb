class TeacherSerializer < BaseSerializer
  attributes :name
  has_many :courses
end
