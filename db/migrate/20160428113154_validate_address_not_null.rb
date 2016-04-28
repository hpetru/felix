class ValidateAddressNotNull < ActiveRecord::Migration
  def change
    change_column :addresses, :street, :string, null: false
    change_column :addresses, :city_id, :integer, null: false
    change_column :cities, :name, :string, null: false
  end
end
