class AddNotNulls < ActiveRecord::Migration
  def change
    change_column :students, :gender, :string, null: false
    change_column :students, :inside_code_token, :string, null: false
  end
end
