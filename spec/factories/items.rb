FactoryBot.define do
    factory :track do
        name {Faker::Lorem.sentence}
        number {Faker::Number.between(1, 20)}
        duration {Faker::Number.between(120, 360)}
        record_id nil
    end
end