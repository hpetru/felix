class RenameIdnp < ActiveRecord::Migration
  def change
    rename_column :teachers, :idnp, :idnp_token
  end
end
