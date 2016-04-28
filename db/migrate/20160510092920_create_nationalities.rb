class CreateNationalities < ActiveRecord::Migration
  def change
    create_table :nationalities do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
