require 'rails_helper'

describe FlexyTable::Base do
  describe '#valid?' do
    it 'is true' do
      strategy = described_class.new('')

      expect(strategy.valid?).to eq(true)
    end
  end
end
