# db/seeds.rb
JUser.destroy_all

JUser.create!(
  email: "shivam011@gmail.com",
  password: "123",
)

JUser.create!(
  email: "user2@example.com",
  password: "456",
)

puts "Created #{JUser.count} JUsers"