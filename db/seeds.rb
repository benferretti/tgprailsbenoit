require 'faker'

City.destroy_all
City.reset_pk_sequence
Gossip.destroy_all
Gossip.reset_pk_sequence
Tag.destroy_all
Tag.reset_pk_sequence
GossipsTag.destroy_all
GossipsTag.reset_pk_sequence
User.destroy_all
User.reset_pk_sequence
PrivateMessage.destroy_all
PrivateMessage.reset_pk_sequence

Faker::Config.locale = 'fr'

cities = Array.new
gossips = Array.new
tags = Array.new
users = Array.new
private_messages = Array.new


100.times do 
  city = City.create(name: Faker::Address.city, zip_code: Faker::Address.zip_code)
  cities << city
  puts "Seeding City #{city.name} #{city.zip_code}"
end

11.times do 
  user = User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  description: Faker::Lorem.sentence,
  age: rand(18..70),
  city_id: cities[rand(0..99)].id,
  password: "Azerty"
  )
  users << user
  puts "Seeding User #{user.first_name} #{user.last_name}"
end

10.times do 
  tag = Tag.create(title: "#" + Faker::Verb.base)
  tags << tag
  puts "Seeding #{tag.title}"
end

20.times do 
  gossip = Gossip.create(title: Faker::DcComics.title,
  content: Faker::ChuckNorris.fact,
  user_id: users[rand(0..9)].id)
  gossips << gossip
  puts "Seeding Gossip #{gossip.title} :  #{gossip.content}"
end

15.times do
  gossiptag = GossipsTag.create(
  gossip_id: gossips[rand(0..19)].id,
  tag_id: tags[rand(0..9)].id)
  puts "Seeding Gossip #{gossiptag.gossip_id} to Tag #{gossiptag.tag_id}"
end

10.times do
  private_message = PrivateMessage.create(
  recipient_id: users[rand(0..9)].id,
  sender_id: users[rand(0..9)].id,
  content: Faker::GreekPhilosophers.quote
  )
  puts "Seeding PM '#{private_message.content}' from User #{private_message.sender_id} to User #{private_message.recipient_id}"
end

20.times do
  comment = Comment.create(
    user_id: users[rand(0..9)].id,
    gossip_id: gossips[rand(0..19)].id,
    content: Faker::TvShows::GameOfThrones.quote 
  )
  puts "Seeding Comment '#{comment.content}' from User #{comment.user_id} to gossip #{comment.gossip_id}"
end
