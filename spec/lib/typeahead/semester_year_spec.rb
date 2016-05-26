require 'rails_helper'

describe Typeahead::SemesterYear do
  describe '.strategy_slug' do
    it do
      expect(described_class.strategy_slug).to eq(
        'semester_year'
      )
    end
  end

  describe '.strategy_inputs_schema' do
    it do
      expect(described_class.strategy_inputs_schema).to eq(
        'query' => String
      )
    end
  end

  describe '#strategy_data' do
    it do
      create(:semester, year: 2015, semester_type: 'first_semester')
      create(:semester, year: 2015, semester_type: 'second_semester')
      create(:semester, year: 2013, semester_type: 'second_semester')
      create(:semester, year: 1990, semester_type: 'second_semester')
      strategy_inputs = {
        'query' => '20'
      }
      strategy = described_class.new(strategy_inputs)

      expect(strategy.strategy_data).to eq(
        [
          {
            value: 2015,
            label: 2015
          },
          {
            value: 2013,
            label: 2013
          }
        ]
      )
    end
  end
end
