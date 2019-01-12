# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

500.times do
    record = Record.create(artist: Faker::Music.band, album: Faker::Music.album, year_released: Faker::Number.between(1960, 2000), year_printed: Faker::Number.between(2000, 2018), condition: Faker::Number.between(1, 10), created_by: User.first.id)
    i = 0
    Faker::Number.between(6, 20).times do
        i += 1
        record.tracks.create(name: Faker::Lorem.sentence, number: i, duration: Faker::Number.between(120, 360))
    end
end