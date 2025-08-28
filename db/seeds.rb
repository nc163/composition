# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.insert_all(1000.times.map do
  { name: Faker::Name.name, email: Faker::Internet.email, state: 'standby', state_changed_at: Time.zone.now }
end)

user_id_range = User.minimum(:id)..User.maximum(:id)
Post.insert_all(3000.times.map do
  { title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, user_id: user_id_range.to_a.sample }
end)

post_id_range = Post.minimum(:id)..Post.maximum(:id)
Comment.insert_all(10_000.times.map do
  { body: Faker::Lorem.sentence, post_id: post_id_range.to_a.sample, user_id: user_id_range.to_a.sample }
end)
