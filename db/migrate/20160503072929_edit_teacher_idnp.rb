class EditTeacherIdnp < ActiveRecord::Migration
  def change
    change_column :teachers, :idnp, :string
  end
end
