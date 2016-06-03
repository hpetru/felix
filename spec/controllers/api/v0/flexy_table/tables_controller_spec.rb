require 'rails_helper'

describe Api::V0::FlexyTable::TablesController do
  render_views

  describe 'POST #create' do
    it do
      table_strategy_slug = 'grades'
      student_group = create(:student_group)
      column_input_settings = {
        'student_group_id' => student_group.id
      }
      column = build(:flexy_memory_column)
      table = create(
        :flexy_memory_table,
        columns: [
          column
        ]
      )
      allow(FlexyMemory::Table).to receive(:fetch_or_create).
        with(table_strategy_slug, column_input_settings).
        and_return(table)

      post(
        :create,
        table: {
          table_strategy_slug: table_strategy_slug,
          column_input_settings: JSON.generate(
            column_input_settings
          )
        }
      )
      response_hash = JSON.parse(response.body)

      expect(response_hash).to eq(
        'id' => table.id,
        'table_strategy_slug' => table.table_strategy_slug,
        "column_input_settings" => table.column_input_settings,
        'columns' => [
          {
            'id' => column.id,
            'strategy_slug' => column.strategy_slug,
            'strategy_inputs' => column.strategy_inputs,
            'cells' => column.cells,
            'schema' => column.schema
          }
        ]
      )
    end
  end
end
