class AllowNullProfile < ActiveRecord::Migration
  def change
    change_column_null :student_groups, :profile_slug, true
  end
end
