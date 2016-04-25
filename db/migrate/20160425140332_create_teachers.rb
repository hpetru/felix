class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :birthday, null: false
      t.string :phone
      t.string :degree
      t.string :graduated_from
      t.integer :degree_reeval_year
      t.boolean :retired, default: false
      t.boolean :sindicate_member, default: false

      t.timestamps null: false
    end
  end
end
