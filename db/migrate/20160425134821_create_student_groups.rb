class CreateStudentGroups < ActiveRecord::Migration
  def change
    create_table :student_groups do |t|
      t.integer :promotion, null: false
      t.string :suffix, char: 1, null: false
      t.string :profile_slug, null: false

      t.timestamps null: false
    end
  end
end
