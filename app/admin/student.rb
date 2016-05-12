ActiveAdmin.register Student do
  permit_params :first_name, :last_name, :student_group_id
  menu label: 'Elevi', priority: 1

  filter :last_name
  filter :first_name
  filter :student_group, as: :select
  filter :birthday
  filter :foreign_language
  filter :nationality, as: :select
  filter :gender, as: :select, collection: [['Băieți', 'male'], ['Fete', 'female']]
  filter :came_from, as: :select,
    input_html: {class: 'select2able'},
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
end
