class RemoveGradeTypeFromStudentSemesterGrades < ActiveRecord::Migration
  def change
    remove_column :student_semester_grades, :grade_type
  end
end
