class TeacherSerializer < BaseSerializer
  attributes :provider, :uid, :email, :token, :first_name, :last_name, :school_name, :school_district
  has_many :courses
end
