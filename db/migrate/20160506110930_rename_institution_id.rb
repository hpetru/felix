class RenameInstitutionId < ActiveRecord::Migration
  def change
    remove_column :students, :came_from
    rename_column :teachers, :institution_id, :graduated_from_id
    add_column :students, :came_from_id, :integer
  end
end
