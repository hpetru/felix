module FlexyTable
  module Grades
    STRATEGIES = [
      Grades::StudentName,
      Grades::StudentSubjectGrade
    ].freeze

    def self.table_strategy_slug
      'grades'
    end

    def self.default_columns(column_input_settings)
      [
        {
          'strategy_slug' => 'student_name',
          'strategy_inputs' => {
            'student_group_id' => column_input_settings['student_group_id']
          }
        }
      ]
    end
  end
end
