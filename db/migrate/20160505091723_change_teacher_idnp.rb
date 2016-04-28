class ChangeTeacherIdnp < ActiveRecord::Migration
  def change
    change_column_default(:teachers, :idnp, nil)
  end
end
