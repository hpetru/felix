class SetDefaultNationality < ActiveRecord::Migration
  def change
    change_column :students, :nationality, :string, default: 'mold', null: false
  end
end
