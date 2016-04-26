class CreateStudentAnualGrades < ActiveRecord::Migration
  def change
    create_table :student_anual_grades do |t|
      t.integer :subject_id, null: false
      t.float :value, null: false
      t.integer :year, null: false
      t.integer :student_id, null: false

      t.timestamps null: false
    end
  end
end
