class CreateStudentGroupMainTeachers < ActiveRecord::Migration
  def change
    create_table :student_group_main_teachers do |t|
      t.integer :student_group_id, null: false
      t.integer :teacher_id, null: false

      t.timestamps null: false
    end
  end
end
