class CreateFlexyMemoryTables < ActiveRecord::Migration
  def change
    create_table :flexy_memory_tables do |t|
      t.string :table_strategy_slug, null: false
      t.jsonb :column_input_settings, null: false, default: {}

      t.timestamps null: false
    end
  end
end
