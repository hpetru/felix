class MakeProfileNotRequired < ActiveRecord::Migration
  def change
    change_column :student_groups, :profile_slug, :string, required: false
  end
end
