User.destroy_all
Place.destroy_all

Faker::UniqueGenerator.clear

10.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(8)
  )
end

20.times do
  place = Place.new(
    name: Faker::Space.planet,
    description: Faker::Hipster.sentence,
    address: Faker::Address.street_address,
    price: (1000..3000).to_a.sample,
    user: User.all.sample
  )
  place.photo = Rails.root.join("db/seed_images/#{(1..20).to_a.sample}.jpg").open
  place.save!
end
