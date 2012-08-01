
require 'spec_helper'

describe Cart do
  it "should have a valid factory" do
    create(:cart).should be_valid
  end

  it "should calculate the total price" do
    cart = build(:cart)
    cart.products.first.price = 20
    
    cart.products << build(:product, price: 12)
    cart.products << build(:product, price: 8)

    cart.total_price.should be_eql 40
  end
end