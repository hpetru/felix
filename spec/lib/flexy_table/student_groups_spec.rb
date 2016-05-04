require 'rails_helper'

describe FlexyTable::StudentGroups do
  describe '.table_strategy_slug' do
    it do
      expect(described_class.table_strategy_slug).to eq(
        'student_groups'
      )
    end
  end

  describe '.default_columns' do
    it do
<<<<<<< be8d20990fe23644f22e7b84a504c355a585ee92
      expect(described_class.default_columns).to eq(
        [
          {
            strategySlug: 'current_grade',
            strategyInputs: {}
          },
          {
            strategySlug: 'letter',
            strategyInputs: {}
          },
          {
            strategySlug: 'main_teacher_name',
            strategyInputs: {}
          },
          {
            strategySlug: 'students_count',
            strategyInputs: {}
          }
        ]
      )
=======
      expect(described_class.default_columns).to eq([
        {
          strategySlug: 'current_grade',
          strategyInputs: {}
        },
        {
          strategySlug: 'letter',
          strategyInputs: {}
        },
        {
          strategySlug: 'main_teacher_name',
          strategyInputs: {}
        },
        {
          strategySlug: 'students_count',
          strategyInputs: {}
        }
      ])
>>>>>>> backend spike
    end
  end
end
