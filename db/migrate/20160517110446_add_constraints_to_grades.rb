class AddConstraintsToGrades < ActiveRecord::Migration
  def change
    add_index :student_semester_grades,
      [:student_id, :semester_id, :subject_id],
      name: :student_semester_grades_uniqueness,
      unique: true
    add_index :student_thesis_grades,
      [:student_id, :semester_id, :subject_id],
      name: :student_thesis_grades_uniqueness,
      unique: true
    add_index :student_annual_grades,
      [:student_id, :year, :subject_id],
      name: :student_annual_grades_uniqueness,
      unique: true
  end
end
