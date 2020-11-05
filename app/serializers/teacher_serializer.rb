class TeacherSerializer < BaseSerializer
  attributes :provider, :uid, :email, :token, :first_name, :last_name, :school_name, :school_district, :role
  has_many :courses
end
