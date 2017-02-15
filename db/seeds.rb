puts "Destroying records"

User.destroy_all
Place.destroy_all
Reservation.destroy_all

Faker::UniqueGenerator.clear

puts "Seeding users"

i = 1
10.times do
  user = User.new(
    email: Faker::Internet.unique.email,
    password: "123456",
    first_name: Faker::StarWars.character
  )
  user.photo = Rails.root.join("db/seed_avatars/#{i}.jpg").open
  user.save!
  i += 1
end

user = User.new(
  email: "rafmillan@gmail.com",
  password: "123456",
  first_name: "Rafael"
)
user.photo = Rails.root.join("db/seed_avatars/rafael.jpg").open
user.save!

puts "Seeding places"

i = 1
20.times do
  place = Place.new(
    name: Faker::Space.moon,
    description: Faker::StarWars.quote,
    address: "#{(100..5000).to_a.sample} #{Faker::Space.star}, #{Faker::Space.galaxy}",
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
