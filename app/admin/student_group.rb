ActiveAdmin.register StudentGroup do
  permit_params :promotion, :suffix, :main_teacher_id, :profile_slug

  index do
    column :current_grade
    column :suffix
    column :main_teacher
    column :profile_slug
    column :students_count
    actions
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
