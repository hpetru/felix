FactoryGirl.define do
  factory :flexy_memory_column, class: 'FlexyMemory::Column' do
    association(
      :table,
      factory: :flexy_memory_table,
      strategy: :build
    )
    strategy_inputs do
      grade_type = 'semester'
      student_group = create(:student_group)
      subject = create(:subject)
      semester = create(:semester)
      {
        'subject_id' => subject.id,
        'student_group_id' => student_group.id,
        'grade_type' => grade_type,
        'semester_id' => semester.id
      }
    end
    strategy_slug 'student_subject_grade'
  end

  factory :flexy_memory_table, class: 'FlexyMemory::Table' do
    table_strategy_slug 'grades'
    column_input_settings do
      student_group = create(:student_group)
      {
        'student_group_id' => student_group.id
      }
    end
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

  factory :student_grade do
    value 9
    grade_type 'semester'
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

  factory :user do
    sequence(:email) { |n| "me#{n}@example.com" }
    password '1' * 10
  end
end
