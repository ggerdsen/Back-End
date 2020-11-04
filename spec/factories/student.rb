# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    provider { "google" }
    uid { Faker::Number.number(digits: 5) }
    email { Faker::Internet.email }
    token { Faker::Alphanumeric.alphanumeric(number: 12) }
    refresh_token { Faker::Alphanumeric.alphanumeric(number: 12) }
    role { "teacher" }
  end
end
