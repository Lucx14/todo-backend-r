FactoryBot.define do
  factory :todo do
    title { Faker::Lorem.words(number: 1) }
    created_by { Faker::Number.number(digits: 10) }
  end
end
