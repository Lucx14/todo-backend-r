FactoryBot.define do
  factory :item do
    name { Faker::TvShows::TwinPeaks.character }
    done { false }
    todo { nil }
  end
end
