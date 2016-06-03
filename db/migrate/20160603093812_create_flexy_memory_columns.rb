class CreateFlexyMemoryColumns < ActiveRecord::Migration
  def change
    create_table :flexy_memory_columns do |t|
      t.integer :flexy_memory_table_id, null: false
      t.jsonb :strategy_inputs, null: false, default: {}
      t.string :strategy_slug, null: false

      t.timestamps null: false
    end
  end
end
