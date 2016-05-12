ActiveAdmin.register Student do
  permit_params(
    :first_name,
    :last_name,
    :student_group_id,
    :came_from_id,
    :came_at,
    :nationality_id,
    :idnp_token,
    :address_id,
    :address_house,
    :address_appartment,
    :father_last_name,
    :father_first_name,
    :father_email,
    :father_phone_number,
    :mother_last_name,
    :mother_first_name,
    :mother_email,
    :mother_phone_number,
    :gender,
    :foreign_language_id,
    :born_at
  )

  menu label: 'Elevi', priority: 1

  filter :last_name
  filter :first_name
  filter :student_group, as: :select
  filter :birthday
  filter :foreign_language
  filter :nationality, as: :select
  filter :gender, as: :select, collection: [['Băieți', 'male'], ['Fete', 'female']]
  filter :came_from, as: :select,
    input_html: { class: 'select2able' },
    collection: Institution.joins(:students).uniq(:name).order(:name)

  index title: 'Elevi' do
    column :inside_code_token
    column :first_name
    column :last_name
    column :student_group,
      sortable: 'student_group.promotion, student_group.suffix'
    actions
  end

  show title: ->(student) { "Student - #{student}" } do
    attributes_table do
      row :first_name
      row :last_name
      row :student_group
      row :main_teacher
    end
  end

  form do |f|
    f.inputs 'Date generale' do
      f.input :last_name
      f.input :first_name
      f.input :born_at, as: :datepicker,
        input_html: { placeholder: '1994-02-29' }
      f.input :gender, as: :select,
        include_blank: false
      f.input :idnp_token
      f.input :nationality, as: :select,
        include_blank: false
    end

    f.inputs 'Informație clasă' do
      f.input :came_from,
        input_html: { class: 'select2able' }
      f.input :came_at, as: :datepicker,
        input_html: { placeholder: '2016-01-01' }
      f.input :foreign_language
      f.input :student_group, as: :select,
        include_blank: false,
        input_html: { class: 'select2able' }
    end

    f.inputs 'Adresa' do
      f.input :address,
        label_method: :display_name,
        input_html: { class: 'select2able' }
      f.input :address_house
      f.input :address_appartment
    end

    f.inputs 'Informație tată' do
      f.input :father_last_name
      f.input :father_first_name
      f.input :father_phone_number
      f.input :father_email
    end

    f.inputs 'Informație mamă' do
      f.input :mother_last_name
      f.input :mother_first_name
      f.input :mother_phone_number
      f.input :mother_email
    end

    actions
  end
end
