# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development?
  User.delete_all  
  Category.delete_all
  Product.delete_all
end

User.create!(email: "user@rubyshop.co", password: "123456", admin: false)
User.create!(email: "admin@rubyshop.co", password: "123456", admin: true)

colors = ['Red', 'Blue', 'Yellow', 'Green', 'Gray']

['Books', 'Movies', 'Clothes', 'Shoes', 'Computers'].each do |category_name|
  random_color = colors[Random.rand(5)]
  cat = Category.create!(name: category_name, color: random_color)
  
  ['Product xxx', 'Product yyy', 'Product zzz'].each do |product_name|
    Product.create!(name: product_name, price: 100, qty: 50, on_sale: false, category: cat, sale_price: 80)
  end
end