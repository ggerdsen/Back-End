# frozen_string_literal: true

class Student < ApplicationRecord
  has_many :course_students, dependent: :destroy
  has_many :courses, through: :course_students

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :token, presence: true
  validates :role, presence: true

  def self.update_or_create(auth)
    student = Student.find_by(uid: auth[:user_data][:uid]) || Student.new
    student.attributes = {
      provider: auth[:user_data][:provider],
      uid: auth[:user_data][:uid],
      email: auth[:user_data][:info][:email],
      first_name: auth[:user_data][:info][:first_name],
      last_name: auth[:user_data][:info][:last_name],
      token: auth[:user_data][:credentials][:token],
      role: "student"
      }

    student.save

    student
  end
end
