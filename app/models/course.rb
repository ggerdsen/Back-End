# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :teacher
  has_many :course_students
  has_many :students, through: :course_students

  validates_presence_of :name,
                        :course_code,
                        :school_name
  validates_associated :teacher
end
