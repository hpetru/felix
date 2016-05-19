ActiveAdmin.register Teacher do
  config.sort_order = %w(
    last_name_asc
    first_name_asc
    birthday_desc
  ).join('_and_')

  menu label: 'Profesori', priority: 3
  permit_params(
    :first_name,
    :last_name,
    :birthday,
    :syndicate_member,
    :retired,
    :phone,
    :gender,
    subject_ids: []
  )

  filter :last_name
  filter :first_name
  filter :birthday
  filter :gender, as: :select,
          collection: [['Masculin', 'male'], ['Feminin', 'female']]
  filter :graduated_from, as: :select,
          collection: Institution.joins(:teachers).uniq(:name).order(:name)
  filter :degree, as: :select, collection: [
    ['Doctorat', 'doctorate'],
    ['Superior', 'superior_degree'],
    ['Gardul I', 'first_degree'],
    ['Gardul II', 'second_degree'],
    ['Gardul III', 'third_degree'],
  ]

  filter :degree_reeval_year
  filter :retired, as: :boolean
  filter :syndicate_member, as: :boolean

  index title: 'Profesori' do
    column :last_name
    column :first_name
    column :student_groups do |teacher|
      teacher.student_groups.order(:promotion, :suffix).map do |group|
        link_to group.display, admin_student_group_path(group)
      end.join('; ').html_safe
    end
    column :subjects do |teacher|
      teacher.subjects.order(:name).map(&:name).join('; ')
    end

    actions defaults: false do |teacher|
      link_to 'Vizualizare', admin_teacher_path(teacher)
    end
    actions defaults: false do |teacher|
      link_to 'Editare', edit_admin_teacher_path(teacher)
    end
  end

  show title: ->(teacher) { "Profesor - #{teacher.full_name}" } do
    panel 'Date generale' do
      attributes_table_for teacher do
        row :first_name
        row :last_name
        row :birthday
        row :idnp_token
      end
    end

    panel 'Date profesionale' do
      attributes_table_for teacher do
        row :subjects do
          teacher.subjects.order(:name).map(&:name).join('; ')
        end

        row :student_groups do
          teacher.student_groups.order(:promotion, :suffix).map do |group|
            link_to group.display, admin_student_group_path(group)
          end.join('; ').html_safe
        end

        row :retired
        row :syndicate_member
        row :phone

        row :graduated_from
        row :degree_display
        row :degree_reeval_year
      end
    end
  end

  form do |f|
    f.inputs 'Date generale' do
      f.input :last_name
      f.input :first_name
      f.input :birthday, as: :datepicker,
        input_html: { placeholder: '1994-02-29' }
      f.input :gender, as: :select,
        include_blank: false, collection: [['M', 'male'], ['F', 'female']]
      f.input :phone
      f.input :subject_ids, as: :select, multiple: true,
        collection: Subject.all_as_selectable,
        input_html: { style: 'height: 200px;' }
      f.input :degree, as: :select, collection: [
        ['Doctorat', 'doctorate'],
        ['Superior', 'superior_degree'],
        ['Gardul I', 'first_degree'],
        ['Gardul II', 'second_degree'],
        ['Gardul III', 'third_degree'],
      ]

      f.input :retired, as: :boolean
      f.input :syndicate_member, as: :boolean

      f.actions do
        f.submit 'Salvează profesor'
        f.cancel_link
      end
    end
  end
end
