class ChangeTimestampsToDates < ActiveRecord::Migration
  def change
    change_column :students, :birthday, :date
    change_column :students, :came_at, :date
  end
end
