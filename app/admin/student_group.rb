ActiveAdmin.register StudentGroup do
  permit_params :promotion, :suffix, :main_teacher_id, :profile_slug
  menu label: 'Clase', priority: 2

  index title: 'Clase' do
    column :current_grade, sortable: :promotion
    column :suffix
    column :main_teacher
    column :profile_slug
    column :students_count
    actions
  end

  show title: ->(group) { "Clasa #{group}" } do |group|
    panel 'Studenți' do
      table_for group.students, sortable: true do
        column 'Nume student' do |student|
          a student.full_name, href: admin_student_path(student)
        end
        column :gender
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
      row :current_grade
      row :suffix
      row :profile_slug
      row :main_teacher
      row :students_count
    end
  end

  form do |f|
    f.inputs do
      f.input :promotion, as: :number
      f.input :suffix
      f.input :main_teacher, member_label: :full_name,
              include_blank: false
      f.input :profile_slug, as: :select, include_blank: false,
              collection: StudentGroup.profile_slugs.keys
    end
    f.actions
  end
end
