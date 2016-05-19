class CreateStudentGrades < ActiveRecord::Migration
  def change
    create_table :student_grades do |t|
      t.float :value, null: false
      t.string :grade_type, null: false

      t.timestamps null: false
    end

    add_reference(:student_grades, :student, foreign_key: true, null: false)
    add_reference(:student_grades, :semester, foreign_key: true, null: false)
    add_reference(:student_grades, :subject, foreign_key: true, null: false)
  end
end
