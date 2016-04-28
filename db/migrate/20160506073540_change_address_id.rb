class ChangeAddressId < ActiveRecord::Migration
  def change
    change_column :students, :address_id, 'integer USING CAST(address_id AS integer)'
  end
end
