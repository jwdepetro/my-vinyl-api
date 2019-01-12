FactoryBot.define do 
    factory :user do 
        name {Faker::Name.name}
        email {'test@test.com'}
        password {'foobar'}
    end
end