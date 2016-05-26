module FlexyTable
  module Grades
    STRATEGIES = [
      Grades::StudentName,
      Grades::StudentSubjectGrade
    ].freeze

    def self.table_strategy_slug
      'grades'
    end

    def self.default_columns(student_group)
      [
        {
          strategySlug: 'student_name',
          strategyInputs: {
            student_group_id: student_group.id
          }
        }
      ]
    end
  end
end
