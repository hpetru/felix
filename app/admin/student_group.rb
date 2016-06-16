ActiveAdmin.register StudentGroup do
  permit_params :promotion, :suffix, :main_teacher_id, :profile_slug
  menu label: 'Clase', priority: 2
  scope 'Clase curene', :current, default: true
  scope 'Clase absolvente', :graduate
  filter :main_teacher
  filter :start_year
  filter :suffix, as: :select
  filter :profile_slug, as: :select, collection: [['Real', 'real'], ['Uman', 'humanitarian']]

  config.clear_action_items!

  action_item only: :index do
    link_to('Clasă nouă', new_resource_path)
  end

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
    attributes_table do
      row :promotion
      row :current_grade_safe
      row :suffix
      row :main_teacher
      row :students_count
    end
    render 'grades_table'
  end

  form title: 'Modificare clasă' do |f|
    f.inputs do
      f.input :promotion, as: :number
      f.input :suffix
      f.input :main_teacher, member_label: :full_name,
              include_blank: false, collection: Teacher.order(:last_name, :first_name)
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

  controller do
    def show
      super do
        @table_strategy_slug = FlexyTable::Grades.table_strategy_slug
      end
    end
  end

  csv do
    column :current_grade_safe
    column :suffix
    column :promotion
    column :main_teacher
    column :profile_display
    column :students_count
  end
end
