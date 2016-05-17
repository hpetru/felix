FactoryGirl.define do
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
    inside_code_token 'P-00934'
    born_at Date.current - 18.years
    association(
      :student_group,
      factory: :student_group
    )
    association(
      :nationality,
      factory: :nationality
    )
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

  factory :nationality do
    name 'rom'
  end

  factory :subject do
    name 'Maths'
  end

  factory :semester do
    year 2015
    semester_type 'first_semester'
  end

  factory :student_semester_grade do
    value 9
    association(
      :student,
      factory: :student
    )
    association(
      :subject,
      factory: :subject
    )
    association(
      :semester,
      factory: :semester
    )
  end

  factory :student_thesis_grade do
    value 9
    association(
      :student,
      factory: :student
    )
    association(
      :subject,
      factory: :subject
    )
    association(
      :semester,
      factory: :semester
    )
  end

  factory :student_annual_grade do
    value 9.5
    year 2015
    association(
      :student,
      factory: :student
    )
    association(
      :subject,
      factory: :subject
    )
  end

  factory :user do
    sequence(:email) { |n| "me#{n}@example.com" }
    password '1' * 10
  end

  factory :semester do
    study_year 2013
    semester_type :first_semester
  end
end
