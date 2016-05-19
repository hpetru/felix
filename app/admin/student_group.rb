ActiveAdmin.register StudentGroup do
  permit_params :promotion, :suffix, :main_teacher_id, :profile_slug
  menu label: 'Clase', priority: 2
  scope 'Clase curene', :current, default: true
  scope 'Clase absolvente', :graduate
  filter :main_teacher
  filter :start_year
  filter :suffix, as: :select
  filter :profile_slug, as: :select, collection: [['Real', 'real'], ['Uman', 'humanitarian']]

  index title: 'Clase' do
    column :current_grade_safe, sortable: :promotion
    column :suffix
    column :promotion
    column :main_teacher
    column :profile_display, sortable: :profile_slug
    column :students_count
    actions defaults: false do |group|
      link_to 'Vizualizare', admin_student_group_path(group)
    end
    actions defaults: false do |group|
      link_to 'Editare', edit_admin_student_group_path(group)
    end
  end

  show title: ->(group) { "Clasa #{group}" } do |group|
    panel 'Studenți' do
      table_for group.students, sortable: true do
        column 'Nume student' do |student|
          a student.full_name, href: admin_student_path(student)
        end
        column :display_gender
        column :age
        column :foreign_language
      end
    end

    panel 'Note' do
      render 'grades_table'
    end
  end

  sidebar 'Detalii', only: :show do
    attributes_table do
      row :promotion
      row :current_grade_safe
      row :suffix
      row :profile_display
      row :main_teacher
      row :students_count
    end
  end

  form title: 'Modificare clasă' do |f|
    f.inputs do
      f.input :promotion, as: :number
      f.input :suffix
      f.input :main_teacher, member_label: :full_name,
              include_blank: false
      f.input :profile_slug, as: :select, collection: [
        ['Real', 'real'],
        ['Uman', 'humanitarian']
      ]
    end

    f.actions do
      f.submit 'Salvează clasa'
      f.cancel_link
    end
  end
end
