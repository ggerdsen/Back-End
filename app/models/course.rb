# frozen_string_literal: true

class Course < ApplicationRecord
  before_create :generate_course_code
  belongs_to :teacher
  has_many :course_students, dependent: :destroy
  has_many :students, through: :course_students

  validates_presence_of :name,
                        :school_name,
                        :course_points

  validates_associated :teacher

  def generate_course_code
    self.course_code = 8.times.map { [*'0'..'9', *'a'..'z', *'A'..'Z'].sample }.join
  end
end
