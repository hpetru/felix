require 'rails_helper'

describe Api::V0::FlexyTable::ColumnsController do
  render_views

  describe 'POST #create' do
    it do
      table = create(:flexy_memory_table)
      column = build(:flexy_memory_column)

      post(
        :create,
        table_id: table.id,
        column: {
          strategy_slug: column.strategy_slug,
          strategy_inputs: JSON.generate(
            column.strategy_inputs
          )
        }
      )
      column = FlexyMemory::Column.first
      response_hash = JSON.parse(response.body)

      expect(response_hash).to eq(
        'id' => column.id,
        'cells' => column.cells,
        'strategy_inputs' => column.strategy_inputs,
        'strategy_slug' => column.strategy_slug,
        'schema' => column.schema
      )
    end
  end
end
