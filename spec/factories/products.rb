FactoryGirl.define do 
  factory :product do
    sequence(:name) { |i| "Product #{i}" }
    description "Some description" 
    qty 5
    on_sale false
    price 100
    sale_price 80
    association(:category)
  end 
end