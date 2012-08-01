FactoryGirl.define do 
  factory :category do
    sequence(:name) {|i| "Category #{i}"} 
    color "red"
  end 

  factory :category_with_products, :parent => :category do |f|
    f.before_create {|x| 
      x.products << FactoryGirl.build(:product)
    }   
  end 
end