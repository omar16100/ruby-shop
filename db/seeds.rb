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

  User.create!(email: "user@rubyshop.co", password: "123456", admin: false)
  User.create!(email: "admin@rubyshop.co", password: "123456", admin: true)

  ['Books', 'Movies', 'Clothes', 'Shoes', 'Computers'].each do |category_name|
    cat = Category.create!(name: category_name, color: 'red')
    ['Product xxx', 'Product yyy', 'Product zzz'].each do |product_name|
      Product.create!(name: product_name, price: 100, qty: 50, on_sale: false, category: cat, sale_price: 80)
    end
  end
end