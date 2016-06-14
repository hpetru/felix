require 'rails_helper'

describe Typeahead::SubjectName do
  describe '.strategy_slug' do
    it do
      expect(described_class.strategy_slug).to eq(
        'subject_name'
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
      subjects = [
        create(:subject, name: 'Limba franceza'),
        create(:subject, name: 'Limba romana'),
        create(:subject, name: 'Matematica')
      ]
      strategy_inputs = {
        'query' => 'limba'
      }
      strategy = described_class.new(strategy_inputs)

      expect(strategy.strategy_data).to eq(
        [
          {
            value: subjects[0].id,
            label: subjects[0].name
          },
          {
            value: subjects[1].id,
            label: subjects[1].name
          }
        ]
      )
    end
  end
end
