module FlexyTable
  module StudentGroups
    STRATEGIES = [
      StudentGroups::CurrentGrade
    ].freeze

    def self.table_strategy_slug
      'student_groups'
    end

    def self.default_columns
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
    end
  end
end
