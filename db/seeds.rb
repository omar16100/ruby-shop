# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

class SampleData

  def create_users
    User.delete_all   if Rails.env.development?
    User.create!(email: "user@rubyshop.co", password: "123456", admin: false)
    User.create!(email: "admin@rubyshop.co", password: "123456", admin: true)
  end

  def create_categories
    Category.delete_all  if Rails.env.development?
    colors = ['Red', 'Blue', 'Yellow', 'Green', 'Gray', 'Orange', 'Cyan']

    ['Books', 'Movies', 'Clothes', 'Shoes', 'Computers'].each do |category_name|
      random_color = colors[Random.rand(5)]
      cat = Category.create!(name: category_name, color: random_color)
    end
  end

  def create_products
    Product.delete_all if Rails.env.development?
    Category.all.each do |cat|
      ['Product A', 'Product B', 'Product C', 'Product X', 'Product Y', 'Product Z'].each do |product_name|
        Product.create!(name: product_name, price: 100, qty: 50, on_sale: false, category: cat, sale_price: 80, description: "this product belogns to #{cat.name} category, and also contains")
      end
    end
  end
  
  def run
    create_users
    create_categories
    create_products
  end  
end

SampleData.new.run