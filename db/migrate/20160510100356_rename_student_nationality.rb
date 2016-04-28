class RenameStudentNationality < ActiveRecord::Migration
  def change
    remove_column :students, :nationality
    add_column :students, :nationality_id, :integer, null: false
  end
end
