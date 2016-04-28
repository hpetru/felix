class AddSyndicateMember < ActiveRecord::Migration
  def change
    add_column :teachers, :syndicate_member, :boolean, default: false
  end
end
