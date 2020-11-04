# frozen_string_literal: true

class StudentSerializer < BaseSerializer
  attributes :provider, :uid, :email, :token, :first_name, :last_name, :role
  has_many :courses, through: :course_students
end
