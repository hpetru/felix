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
      strategy = described_class.new('')
      allow(strategy).to receive(:strategy_data).
        and_return(strategy_data_stub)
      allow(strategy).to receive(:strategy_column).
        and_return(strategy_column_stub)

      expect(strategy.data).to eq(
        'cells' => strategy_data_stub,
        'column' => strategy_column_stub
      )
    end
  end
end
