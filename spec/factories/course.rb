# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    name { Faker::Educator.subject }
    course_code { Faker::Alphanumeric.alpha(number: 8) }
    school_name { Faker::Educator.university }
    association :teacher
  end
end
