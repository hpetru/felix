class RenameTableColleges < ActiveRecord::Migration
  def change
    rename_table :colleges, :institutions
  end
end
