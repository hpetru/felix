class RenameStudentSubjectid < ActiveRecord::Migration
  def change
    rename_column :students, :subject_id, :foreign_language_id
  end
end
