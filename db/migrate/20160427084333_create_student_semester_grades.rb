class CreateStudentSemesterGrades < ActiveRecord::Migration
  def change
    create_table :student_semester_grades do |t|
      t.float :value, null: false
      t.integer :subject_id, null: false
      t.integer :year, null: false
      t.string :semester, null: false
      t.integer :student_id, null: false
      t.string :grade_type, null: false

      t.timestamps null: false
    end
  end
end
