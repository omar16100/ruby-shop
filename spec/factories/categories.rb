FactoryGirl.define do 
  factory :category do
    sequence(:name) {|i| "Category #{i}"} 
    color "red"
  end 
end