# db/seeds.rb
JUser.destroy_all

JUser.create!(
  email: "shivam011@gmail.com",
  password: "123",
  createdAt: "1pm",
  updateAt: "2pm" 
)

JUser.create!(
  email: "user2@example.com",
  password: "456",
  createdAt: "3pm",
  updateAt: "4pm"
)

puts "Created #{JUser.count} JUsers"