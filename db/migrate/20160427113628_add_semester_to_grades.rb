class AddSemesterToGrades < ActiveRecord::Migration
  def change
    rename_table :studen_thesis_grades, :student_thesis_grades

    remove_column :student_semester_grades, :year
    remove_column :student_semester_grades, :semester
    add_column :student_semester_grades, :semester_id, :integer, null: false

    remove_column :student_thesis_grades, :year
    remove_column :student_thesis_grades, :semester
    add_column :student_thesis_grades, :semester_id, :integer, null: false
  end
end
