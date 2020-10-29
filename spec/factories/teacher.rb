# frozen_string_literal: true

FactoryBot.define do
  factory :teacher do
    name { Faker::Name.name }
  end
end
