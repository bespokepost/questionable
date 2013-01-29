
FactoryGirl.define do
  sequence(:email) { |n| "test#{n}@example.com" }

  factory :user do
    email { generate(:email) }
    password 'password'
  end
end
