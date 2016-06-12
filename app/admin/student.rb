ActiveAdmin.register Student do
  scope 'Elevi curenți', :current, default: true
  scope 'Absolvenți', :graduate
  config.sort_order = %w(
    last_name_asc
    first_name_asc
    born_at_desc
  ).join('_and_')

  permit_params(
    :first_name,
    :last_name,
    :student_group_id,
    :came_from_id,
    :came_at,
    :nationality_id,
    :born_at,
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
    :born_at,
    :inside_code_token
  )

  controller do
    def scoped_collection
      Student.includes(:student_group)
    end
  end

  menu label: 'Elevi', priority: 1

  filter :last_name
  filter :first_name
  filter :student_group, as: :select
  filter :born_at
  filter :foreign_language
  filter :nationality, as: :select
  filter :gender, as: :select, collection: [['Băieți', 'male'], ['Fete', 'female']]
  filter :came_from, as: :select,
    input_html: { class: 'select2able' },
    collection: Institution.joins(:students).uniq(:name).order(:name)

  index title: 'Elevi' do
    column :inside_code_token
    column :last_name
    column :first_name
    column :student_group, sortable: 'student_groups.promotion'
    column :born_at

    actions defaults: false do |student|
      link_to 'Vizualizare', admin_student_path(student)
    end
    actions defaults: false do |student|
      link_to 'Editare', edit_admin_student_path(student)
    end
  end

  show title: ->(student) { "Student - #{student}" } do
    panel 'Note' do
      h1 'Aici va fi plasat tabelul dinamic cu note'
    end
  end

  sidebar 'Date generale', only: :show do
    attributes_table_for student do
      row :first_name
      row :last_name
      row :gender_display
      row :born_at
      row :idnp_token
      row :student_group
      row :main_teacher
      row :foreign_language
      row :email
      row :address do
        resource.address.display
      end
      row :address_house
      row :address_appartment
    end
  end

  sidebar 'Informație mamă', only: :show do
    attributes_table_for student do
      row :mother_first_name
      row :mother_last_name
      row :mother_phone_number
      row :mother_email
    end
  end

  sidebar 'Informație tată', only: :show do
    attributes_table_for student do
      row :father_first_name
      row :father_last_name
      row :father_phone_number
      row :father_email
    end
  end

  form do |f|
    f.inputs 'Date generale' do
      f.input :last_name
      f.input :first_name
      f.input :born_at, as: :datepicker,
        input_html: { placeholder: '1994-02-29' }
      f.input :gender, as: :select,
        include_blank: false, collection: [
          ['Băiat', 'male'],
          ['Fată', 'female']
        ]
      f.input :idnp_token
      f.input :nationality, as: :select,
        include_blank: false
    end

    f.inputs 'Informație clasă' do
      f.input :inside_code_token
      f.input :came_from,
        input_html: { class: 'select2able' }
      f.input :came_at, as: :datepicker,
        input_html: { placeholder: '2016-01-01' }
      f.input :foreign_language, # TODO: Fix this hardcode
        collection: [
          Subject.find_by(
            name: 'Limba franceză'
          ),
          Subject.find_by(
            name: 'Limba germană'
          )
        ]
      f.input :student_group, as: :select,
        include_blank: false,
        input_html: { class: 'select2able' }
    end

    f.inputs 'Adresa' do
      f.input :address, input_html: { class: 'select2able' }
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

    f.actions do
      f.submit 'Salvează elev'
      f.cancel_link
    end
  end
end
