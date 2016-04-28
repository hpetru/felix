class AddGenderToStudents < ActiveRecord::Migration
  def change
    add_column :students, :gender, :string, required: true
  end
end
