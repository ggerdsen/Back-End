# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    name { Faker::Educator.subject }
    course_code { Faker::Alphanumeric.alpha(number: 8) }
    school_name { Faker::Educator.university }
    course_points { Faker::Number.within(range: 0..100000) }
    association :teacher
  end
end
