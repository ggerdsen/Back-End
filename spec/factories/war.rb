FactoryBot.define do
  factory :war do
    challenger_course_id { Faker::Number.within(range: 0..20) }
    opponent_course_id { Faker::Number.within(range: 0..20) }
    challenger_course_points { Faker::Number.within(range: 0..100000) }
    opponent_course_points { Faker::Number.within(range: 0..100000) }
    association :teacher
  end
end
