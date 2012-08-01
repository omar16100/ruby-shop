FactoryGirl.define do 
  factory :user do
    first_name "user name"
    last_name "user lastname"
    password "userpassword"
    sequence(:email) { |n| "user-#{n}@example.com" }

    factory :admin_user do
      admin true
    end
  end 
end