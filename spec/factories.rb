FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "me#{n}@example.com" }
    password '1' * 10
  end
end
