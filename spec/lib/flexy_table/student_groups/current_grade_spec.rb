require 'rails_helper'

describe FlexyTable::StudentGroups::CurrentGrade do
  describe '.strategy_slug' do
    it do
      expect(described_class.strategy_slug).to eq(
        'current_grade'
      )
    end
  end

  describe '.strategy_inputs_schema' do
    it do
      expect(described_class.strategy_inputs_schema).to eq({})
    end
  end

  describe '#strategy_column' do
    it do
      strategy = described_class.new('')
      expect(strategy.strategy_column).to eq(
        'id' => 'student_groups_current_grade',
        'label' => 'Clasa curentă'
      )
    end
  end

  describe '#strategy_data' do
    it do
      strategy = described_class.new({})
      group1 = create(
        :student_group,
        promotion: 2005
      )
      group2 = create(
        :student_group,
        promotion: 2007
      )

      expect(strategy.strategy_data).to eq(
        [
          [
            group1.id,
            group1.current_grade
          ],
          [
            group2.id,
            group2.current_grade
          ]
        ]
      )
    end
  end
end
