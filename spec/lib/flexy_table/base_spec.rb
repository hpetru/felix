require 'rails_helper'

describe FlexyTable::Base do
  describe '#valid?' do
    it 'is true' do
      strategy_slug_stub = double
      strategy_inputs = {
        'a' => 'ZH'
      }
      strategy_inputs_schema_stub = {
        'a' => String
      }

      allow(described_class).to receive(:strategy_slug).
        and_return(strategy_slug_stub)
      allow(described_class).to receive(:strategy_inputs_schema).
        and_return(strategy_inputs_schema_stub)
      strategy = described_class.new(strategy_inputs)
      expect(strategy.valid?).to eq(true)
    end
  end
end
