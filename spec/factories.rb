FactoryGirl.define do
  factory :nationality do
    name 'Moldovean'
  end

  factory :institution do
    name 'Colegiul Financiar-Bancar Chișinău'
  end

  factory :address do
    street 'Alba-Iulia'
    association(
      :city,
      factory: :city,
      strategy: :build
    )
  end
  factory :city do
    name 'Chișinău'
  end

  factory :student do
    first_name 'Doina'
    last_name 'Prodan'
    gender 'female'
    inside_code 'P-00934'
  end

  factory :teacher do
    first_name 'David'
    last_name 'Breahna'
    birthday '1995-04-25'
    phone '0229999'
    degree 'first_degree'
    gender 'male'
  end

  factory :student_group do
    promotion 2016
    suffix 'A'
    profile_slug 'real'
    association(
      :main_teacher,
      factory: :teacher,
      strategy: :build
    )
  end

  factory :subject do
    name 'Maths'
  end

  factory :user do
    sequence(:email) { |n| "me#{n}@example.com" }
    password '1' * 10
  end
end
