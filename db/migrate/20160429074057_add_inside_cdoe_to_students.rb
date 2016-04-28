class AddInsideCdoeToStudents < ActiveRecord::Migration
  def change
    add_column :students, :inside_code, :string
  end
end
