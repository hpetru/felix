class AddMainTeacherIdToStudentGroup < ActiveRecord::Migration
  def change
    add_column :student_groups, :main_teacher_id, :integer, null: false
  end
end
