class AddFieldsToStudent < ActiveRecord::Migration
  def change
    add_column :students, :nationality, :string
    add_column :students, :came_from, :string
    add_column :students, :came_at, :timestamp
    add_column :students, :came_year, :integer
    add_column :students, :idnp, :string
    add_column :students, :address_id, :string
    add_column :students, :address_house, :string
    add_column :students, :address_appartment, :string
    add_column :students, :father_last_name, :string
    add_column :students, :father_first_name, :string
    add_column :students, :father_phone_number, :string
    add_column :students, :mother_last_name, :string
    add_column :students, :mother_first_name, :string
    add_column :students, :mother_phone_number, :string
    add_column :students, :mother_email, :string
  end
end
