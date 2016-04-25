FactoryGirl.define do
  factory :student do
    first_name 'Doina'
    last_name 'Prodan'
  end

  factory :teacher do
    first_name 'David'
    last_name 'Breahna'
    birthday '1995-04-25'
    phone '0229999'
    degree 'I'
  end

  factory :student_group do
    promotion 2016
    suffix 'A'
    profile_slug 'real'
  end

  factory :subject do
    name 'Maths'
  end

  factory :user do
    sequence(:email) { |n| "me#{n}@example.com" }
    password '1' * 10
  end
end
