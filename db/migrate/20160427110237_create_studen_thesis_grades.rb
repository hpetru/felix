class CreateStudenThesisGrades < ActiveRecord::Migration
  def change
    create_table :studen_thesis_grades do |t|
      t.integer :student_id, null: false
      t.integer :value, null: false
      t.integer :subject_id, null: false
      t.integer :year, null: false
      t.string :semester, null: false

      t.timestamps null: false
    end
  end
end
