module FlexyTable
  module StudentGroups
<<<<<<< be8d20990fe23644f22e7b84a504c355a585ee92
    STRATEGIES = [
      StudentGroups::CurrentGrade
    ].freeze

=======
>>>>>>> backend spike
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
