ActiveAdmin.register Student do
  permit_params :first_name, :last_name, :student_group_id
  menu label: 'Studenți', priority: 1

  index title: 'Studenți' do
    column :id
    column :first_name
    column :last_name
    column :student_group
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
