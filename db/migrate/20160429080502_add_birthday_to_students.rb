class AddBirthdayToStudents < ActiveRecord::Migration
  def change
    add_column :students, :birthday, :timestamp
  end
end
