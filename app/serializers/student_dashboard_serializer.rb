class StudentDashboardSerializer < BaseSerializer
  attributes :name, :course_code, :school_name, :teacher_id, :course_points
  belongs_to :teacher
end
