class RenameInsideCode < ActiveRecord::Migration
  def change
    rename_column :students, :inside_code, :inside_code_token
  end
end
