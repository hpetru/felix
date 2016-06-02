require 'rails_helper'

describe FlexyTable::Base do
  describe '#valid?' do
    it 'is true' do
      strategy = described_class.new('')

      expect(strategy.valid?).to eq(true)
    end
  end

  describe '#data' do
    it do
      strategy_column_stub = double
      strategy_data_stub = double
      strategy_slug_stub = double
      strategy_inputs_stub = double
      allow(described_class).to receive(:strategy_slug).
        and_return(strategy_slug_stub)
      strategy = described_class.new('')
      allow(strategy).to receive(:strategy_data).
        and_return(strategy_data_stub)
      allow(strategy).to receive(:strategy_column).
        and_return(strategy_column_stub)
      allow(strategy).to receive(:strategy_inputs).
        and_return(strategy_inputs_stub)

      expect(strategy.data).to eq(
        'cells' => strategy_data_stub,
        'column' => strategy_column_stub,
        'strategy_slug' => strategy_slug_stub,
        'strategy_inputs' => strategy_inputs_stub
      )
    end
  end
end
