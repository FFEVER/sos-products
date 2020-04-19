# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all

p1 = Product.create(
  title: "Product one of user 1",
  user_id: 1,
  long_desc: "This is my product one of user 1.",
  price: 50,
  stock: 300,
  sold_quantity: 10,
)
puts "#{p1.title} created!"

p2 = Product.create(
  title: "Product two of user 1",
  user_id: 1,
  long_desc: "This is my product two of user 1.",
  price: 30000,
  stock: 20,
  sold_quantity: 0,
)
puts "#{p2.title} created!"

p3 = Product.create(
  title: "Product one of user 2",
  user_id: 2,
  long_desc: "This is my product one of user 2.",
  price: 20,
  stock: 50000,
  sold_quantity: 20,
)
puts "#{p3.title} created!"
