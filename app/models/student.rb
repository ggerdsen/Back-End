# frozen_string_literal: true

class Student < ApplicationRecord
  has_many :course_students
  has_many :courses, through: :course_students

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :token, presence: true
  # validates :refresh_token, presence: true

  def self.update_or_create(auth)
    student = Student.find_by(uid: auth[:uid]) || Student.new
    student.attributes = {
      provider: auth["access_token"]["provider"],
      uid: auth["access_token"]["uid"],
      email: auth["access_token"]["extra"]["raw_info"]["email"],
      first_name: auth["access_token"]["extra"]["raw_info"]["given_name"],
      last_name: auth["access_token"]["extra"]["raw_info"]["family_name"],
      token: auth["access_token"]["credentials"]["token"]
      }

    student.save

    student
  end
end
