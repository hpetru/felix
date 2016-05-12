class ChangeStudentBirthday < ActiveRecord::Migration
  def change
    rename_column :students, :birthday, :born_at
    change_column_null :students, :born_at, false
  end
end
