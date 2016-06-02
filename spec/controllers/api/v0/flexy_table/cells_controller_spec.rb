require 'rails_helper'

describe Api::V0::FlexyTable::CellsController do
  describe 'POST #save' do
    it do
      value = '10'
      table_strategy_slug = 'student_grades'
      column_strategy_slug = 'subject_grade'
      column_strategy_inputs = {
        'is_thesis' => true
      }
      strategy_stub = double
      allow(strategy_stub).to receive(:save)
      allow(FlexyTablePersistence).to receive(:build_strategy).
        with(table_strategy_slug, column_strategy_slug, column_strategy_inputs).
        and_return(strategy_stub)

      post(
        :save,
        value: value,
        table_strategy_slug: table_strategy_slug,
        column_strategy_slug: column_strategy_slug,
        strategy_inputs: JSON.generate(column_strategy_inputs)
      )

      expect(strategy_stub).to have_received(:save)
    end
  end
end
