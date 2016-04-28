class AddIdnp < ActiveRecord::Migration
  def change
    add_column :teachers, :idnp, :boolean, default: false
  end
end
