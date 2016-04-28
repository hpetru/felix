class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.integer :city_id

      t.timestamps null: false
    end
  end
end
