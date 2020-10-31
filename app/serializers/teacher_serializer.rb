class TeacherSerializer < BaseSerializer
  attributes :first_name, :last_name, :provider, :uid, :email, :token, :refresh_token, :school_name, :school_district
  
  has_many :courses
end
