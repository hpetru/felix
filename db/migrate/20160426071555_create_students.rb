class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.references :student_group, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :students, :student_groups
  end
end
