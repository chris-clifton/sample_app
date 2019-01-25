# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
User.create!(name:  "Example User",
             email: "example@example.com",
             password:              "foobarbaz",
             password_confirmation: "foobarbaz",
             admin: true )

99.times do |count|
  name = Faker::Name.name
  email = "example-#{count + 1}@example.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password )
end               