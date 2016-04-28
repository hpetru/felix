class AddFatherEmailToStudents < ActiveRecord::Migration
  def change
    add_column :students, :father_email, :string
  end
end
