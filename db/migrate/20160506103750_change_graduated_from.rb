class ChangeGraduatedFrom < ActiveRecord::Migration
  def change
    rename_column :teachers, :graduated_from, :institution_id
    change_column :teachers, :institution_id, 'integer USING CAST(institution_id AS integer)'
  end
end
