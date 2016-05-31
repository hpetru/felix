require 'rails_helper'

describe Typeahead::SemesterName do
  describe '.strategy_slug' do
    it do
      expect(described_class.strategy_slug).to eq(
        'semester_name'
      )
    end
  end

  describe '.strategy_inputs_schema' do
    it do
      expect(described_class.strategy_inputs_schema).to eq(
        'query' => String,
        'year' => Integer
      )
    end
  end

  describe '#strategy_data' do
    it do
      semesters = [
        create(:semester, year: 2015, semester_type: 'first_semester'),
        create(:semester, year: 2015, semester_type: 'second_semester'),
        create(:semester, year: 2013, semester_type: 'first_semester'),
      ]
      strategy_inputs = {
        'query' => 'I',
        'year' => 2015
      }
      strategy = described_class.new(strategy_inputs)

      expect(strategy.strategy_data).to eq(
        [
          {
            value: semesters[0].id,
            label: semesters[0].display_label
          }
        ]
      )
    end
  end
end
