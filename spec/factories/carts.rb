FactoryGirl.define do 
  factory :cart do
    user { create(:user) }
    products { |product| [ product.association(:product) ] }
  end 
end