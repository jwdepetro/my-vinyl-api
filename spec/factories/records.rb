FactoryBot.define do
    factory :record do
        artist {Faker::Music.band}
        album {Faker::Music.album}
        year_released {Faker::Number.between(1960, 2000)}
        year_printed {Faker::Number.between(2000, 2018)}
        condition {Faker::Number.between(1, 10)}
        created_by {Faker::Number.between(1, 10)}
    end
end