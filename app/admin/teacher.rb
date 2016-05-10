ActiveAdmin.register Teacher do
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
    column :first_name
    column :last_name
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
    attributes_table do
      row :first_name
      row :last_name
      row :student_groups do
        teacher.student_groups.order(:promotion, :suffix).map do |group|
          link_to group.display, admin_student_group_path(group)
        end
      end
      row :subjects do
        teacher.subjects.order(:name).map do |subject|
          subject.name
        end
      end
      row :birthday
      row :retired
      row :syndicate_member
      row :phone
      row :idnp_token
      row :graduated_from
      row :show_degree
      row :degree_reeval_year
    end
  end
end
