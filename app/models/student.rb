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
end
