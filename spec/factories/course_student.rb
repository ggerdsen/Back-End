FactoryBot.define do
  factory :course_student do
    points { Faker::Number.within(range: 0..1000) }
    association :course
    association :student
  end
end