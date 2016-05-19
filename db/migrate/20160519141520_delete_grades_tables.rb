class DeleteGradesTables < ActiveRecord::Migration
  def change
    drop_table :student_semester_grades
    drop_table :student_thesis_grades
    drop_table :student_annual_grades
  end
end
