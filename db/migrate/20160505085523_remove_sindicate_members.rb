class RemoveSindicateMembers < ActiveRecord::Migration
  def change
    remove_column :teachers, :sindicate_member
  end
end
