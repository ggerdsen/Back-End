# frozen_string_literal: true

FactoryBot.define do
  factory :prize do
    name { Faker::Lorem.word }
    prize_points { Faker::Number.within(range: 0..10000) }
  end
end
