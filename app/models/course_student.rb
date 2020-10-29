# frozen_string_literal: true

class CourseStudent < ApplicationRecord
  belongs_to :student
  belongs_to :course

  validates_associated :student, :course
  validates_numericality_of :points, greater_than_or_equal_to: 0
end
