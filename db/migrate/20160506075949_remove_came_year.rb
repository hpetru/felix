class RemoveCameYear < ActiveRecord::Migration
  def change
    remove_column :students, :came_year
  end
end
