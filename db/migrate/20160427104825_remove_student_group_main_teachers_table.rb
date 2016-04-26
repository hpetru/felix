class RemoveStudentGroupMainTeachersTable < ActiveRecord::Migration
  def change
    drop_table :student_group_main_teachers
  end
end
