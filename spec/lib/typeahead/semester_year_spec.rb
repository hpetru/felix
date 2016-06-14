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
      new_time = Time.local(2016, 5, 1, 12, 0, 0)
      Timecop.freeze(new_time)
      group = create(:student_group, promotion: 2015)

      strategy_inputs = {
        'query' => '20',
        'studentGroupId' => group.id
      }

      strategy = described_class.new(strategy_inputs)

      expect(strategy.strategy_data).to eq(
        [
          {
            value: 2015,
            label: '2015 - Clasa 1'
          }
        ]
      )
    end
  end
end
