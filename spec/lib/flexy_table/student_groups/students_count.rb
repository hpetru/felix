require 'rails_helper'

describe FlexyTable::StudentGroups::StudentsCount do
  describe '.strategy_slug' do
    it do
      expect(described_class.strategy_slug).to eq(
        'students_count'
      )
    end
  end

  describe '.strategy_inputs_schema' do
    it do
      expect(described_class.strategy_inputs_schema).to eq({})
    end
  end

  describe '.strategy_column' do
    it do
      expect(described_class.strategy_column).to eq(
        'id' => 'student_groups_students_counts',
        'label' => 'Numărul elevilor'
      )
    end
  end

  describe '#strategy_data' do
    it do
      strategy = described_class.new({})
      group1 = create(
        :student_group,
        suffix: 'D'
      )
      group2 = create(
        :student_group,
        suffix: 'Z'
      )

      expect(strategy.strategy_data).to eq(
        [
          [
            group1.id,
            group1.students.length
          ],
          [
            group2.id,
            group2.students.length
          ],
        ]
      )
    end
  end
end
