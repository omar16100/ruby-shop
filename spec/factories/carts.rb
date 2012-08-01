FactoryGirl.define do 
  factory :cart do
    products { |product| [ product.association(:product) ] }
  end 
end