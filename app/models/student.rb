# frozen_string_literal: true

class Student < ApplicationRecord
  has_many :course_students, dependent: :destroy
  has_many :courses, through: :course_students

  validates_presence_of :name
end
