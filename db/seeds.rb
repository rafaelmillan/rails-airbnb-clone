puts "Destroying records"

User.destroy_all
Place.destroy_all
Reservation.destroy_all

Faker::UniqueGenerator.clear

puts "Seeding users"

10.times do
  i = 1
  user = User.new(
    email: Faker::Internet.unique.email,
    password: "123456"
  )
  user.photo = Rails.root.join("db/seed_avatars/#{i}.jpg").open
  user.save!
  i += 1
end

user = User.new(
  email: "rafmillan@gmail.com",
  password: "123456"
)
user.photo = Rails.root.join("db/seed_avatars/rafael.jpg").open
user.save!

puts "Seeding places"

20.times do
  i = 1
  place = Place.new(
    name: Faker::Space.planet,
    description: Faker::Hipster.sentence,
    address: Faker::Address.street_address,
    price: (1000..3000).to_a.sample,
    user: User.all.sample
  )
  place.photo = Rails.root.join("db/seed_images/#{i}.jpg").open
  place.save!
  i += 1
end

puts "Seeding reservations"

50.times do
  place = Place.all.sample
  user = User.all.sample
  while place.user == user
    place = Place.all.sample
    user = User.all.sample
  end
  res = Reservation.new(
    place: place,
    user: user
  )
  status = (1..3).to_a.sample
  if status == 1
    res.status = "accepted"
  elsif status == 2
    res.status = "declined"
  end
  res.save!
end

place = Place.all.sample
place.user = User.last
place.save!

5.times do
  place = User.last.places.sample
  user = User.all.sample
  while place.user == user
    place = Place.all.sample
    user = User.all.sample
  end
  res = Reservation.new(
    place: place,
    user: user
  )
  status = (1..3).to_a.sample
  if status == 1
    res.status = "accepted"
  elsif status == 2
    res.status = "declined"
  end
  res.save!
end
