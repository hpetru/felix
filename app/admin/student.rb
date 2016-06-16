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
    :inside_code_token,
    :street_input,
    :city_input,
    :came_from_input
  )

  controller do
    def scoped_collection
      Student.includes(:student_group)
    end


    def update(options={}, &block)
      student = Student.find(params[:id])
      updated_params = params[:student].except(:street_input, :city_input).permit!
      student.update(updated_params)
      student.city_input = params[:student][:city_input]
      student.street_input = params[:student][:street_input]
      student.came_from_input = params[:student][:came_from_input]
      student.save
      super do |success, failure|
        block.call(success, failure) if block
        failure.html { render :edit }
      end
    end
  end

#  before_create do |student|
#
#      city = City.find_or_create_by(name: student.city_input)
#      student.address = Address.find_or_create_by(street: student.street_input, city_id: city.id)
#    end
#  end

  menu label: 'Elevi', priority: 1

  filter :last_name
  filter :first_name
  filter :student_group, as: :select
  filter :born_at
  filter :foreign_language, as: :select, collection: [
    Subject.find_by(
      name: 'Limba franceză'
    ),
    Subject.find_by(
      name: 'Limba germană'
    )
  ]
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
    panel 'Date generale' do
      attributes_table_for student do
        row :first_name
        row :last_name
        row :gender_display
        row :born_at
        row :idnp_token
        row :student_group
        row :main_teacher
        row :foreign_language
        row :came_from
        row :came_at
        row :email
        row :address do
          resource.address
        end
        row :address_house
        row :address_appartment
      end
    end

    panel 'Informație mamă' do
      attributes_table_for student do
        row :mother_first_name
        row :mother_last_name
        row :mother_phone_number
        row :mother_email
      end
    end

    panel 'Informație tată' do
      attributes_table_for student do
        row :father_first_name
        row :father_last_name
        row :father_phone_number
        row :father_email
      end
    end
  end

  """
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
      row :came_from
      row :came_at
      row :email
      row :address do
        resource.address
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
  """
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
      f.input :came_from_input, as: :autocomplete, url: autocomplete_institution_name_institution_path,
        input_html: { value: f.object.came_from_name }
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
      # f.input :address, input_html: { class: 'select2able' }, collection:
      #  Address.all.map {|a| [a.street, a.street]}
      # f.inputs for: :address do |a|
      #  a.input :name
      # end
      f.input :city_input, as: :autocomplete, url: autocomplete_city_name_city_path,
        input_html: { value: f.object.city_name }
      f.input :street_input, as: :autocomplete, url: autocomplete_address_street_address_path,
        input_html: { value: f.object.street_name }
      # f.input :address, as: :autocomplete, url: autocomplete_address_display_address_path
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

  csv do
    column :first_name
    column :last_name
    column :gender_display
    column :born_at
    column :idnp_token
    column :student_group
    column :main_teacher
    column :foreign_language
    column :came_from
    column :came_at
    column :address
    column :address_house
    column :address_appartment
    column :mother_first_name
    column :mother_last_name
    column :mother_phone_number
    column :mother_email
    column :father_first_name
    column :father_last_name
    column :father_phone_number
    column :father_email
  end
end
