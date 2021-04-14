FactoryBot.define do
  factory :user do
    name { Faker::TvShows::Buffy.character }
    email { Faker::Internet.email }
    password { 'password' }
  end
end
