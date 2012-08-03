FactoryGirl.define do 
  factory :cart do
    user { create(:user) }
  end

  factory :cart_with_products, :parent => :cart do
    products { |product| [ product.association(:product) ] }
  end
end