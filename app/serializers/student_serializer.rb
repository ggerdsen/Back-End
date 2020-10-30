# frozen_string_literal: true

class StudentSerializer < BaseSerializer
  attributes :name
  has_many :courses, through: :course_students
end
