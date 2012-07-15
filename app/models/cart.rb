class Cart < ActiveRecord::Base
  
  attr_accessible :user_id

  def total_price
    sum = 0
    products.each do |product|
      sum =  sum + product.price
    end
    return sum
  end

  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
end
