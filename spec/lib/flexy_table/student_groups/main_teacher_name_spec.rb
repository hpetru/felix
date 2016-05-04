require 'rails_helper'

describe FlexyTable::StudentGroups::MainTeacherName do
  describe '.strategy_slug' do
    it do
      expect(described_class.strategy_slug).to eq(
        'main_teacher_name'
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
        {
          'label': 'Diriginte'
        }
      )
    end
  end

  describe '#strategy_data' do
    it do
      strategy = described_class.new({})
      group1 = create(
        :student_group
      )
      group2 = create(
        :student_group,
        main_teacher: create(
          :teacher,
          first_name: 'Mihai',
          last_name: 'Ermicioi'
        )
      )
      expect(strategy.strategy_data).to eq(
        [
          [
            group1.id,
            group1.main_teacher.full_name
          ],
          [
            group2.id,
            group2.main_teacher.full_name
          ]
        ]
      )
    end
  end
end
