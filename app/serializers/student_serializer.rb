# frozen_string_literal: true

class StudentSerializer < BaseSerializer
  attributes :first_name, :last_name, :provider, :uid, :email, :token, :refresh_token
  has_many :courses, through: :course_students
end
