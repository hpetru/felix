ActiveAdmin.register Teacher do
  config.sort_order = ['last_name_asc', 'first_name_asc', 'birthday_desc']
  menu label: 'Profesori', priority: 3

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
      end
    end
    column :subjects do |teacher|
      teacher.subjects.order(:name).map(&:name)
    end
    actions
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
          teacher.subjects.order(:name).map do |subject|
            link_to subject.name, admin_subject_path(subject)
          end
        end

        row :student_groups do
          teacher.student_groups.order(:promotion, :suffix).map do |group|
            link_to group.display, admin_student_group_path(group)
          end
        end

        row :retired
        row :syndicate_member
        row :phone

        row :graduated_from
        row :show_degree
        row :degree_reeval_year
      end
    end
  end
end
