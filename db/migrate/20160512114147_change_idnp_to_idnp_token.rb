class ChangeIdnpToIdnpToken < ActiveRecord::Migration
  def change
    rename_column :students, :idnp, :idnp_token
  end
end
