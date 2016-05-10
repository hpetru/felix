class RenameAnualGrades < ActiveRecord::Migration
  def change
    rename_table :student_anual_grades, :student_annual_grades
  end
end
