require 'rails_helper'

describe Typeahead do
  describe '.new_strategy' do
    it do
      strategy_stub = double
      strategy_class_stub = double(
        new: strategy_stub
      )
      strategy_slug = double
      strategy_inputs = double
      allow(described_class).to receive(:applicable_strategy).
        with(strategy_slug).
        and_return(strategy_class_stub)
      strategy = described_class.new_strategy(
        strategy_slug,
        strategy_inputs
      )

      expect(strategy).to eq(
        strategy_stub
      )
    end
  end
end
