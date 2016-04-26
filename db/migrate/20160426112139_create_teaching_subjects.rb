class CreateTeachingSubjects < ActiveRecord::Migration
  def change
    create_table :teaching_subjects do |t|
      t.integer :teacher_id, null: false
      t.integer :student_group_id, null: false
      t.integer :subject_id, null: false

      t.timestamps null: false
    end
  end
end
