class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.integer :year, null: false
      t.string :semester_type, null: false

      t.timestamps null: false
    end
  end
end
