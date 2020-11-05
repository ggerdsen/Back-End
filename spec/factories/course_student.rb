# frozen_string_literal: true

FactoryBot.define do
  factory :course_student do
    student_points { Faker::Number.within(range: 0..1000) }
    association :course
    association :student
  end
end
