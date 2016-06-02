module FlexyTablePersistence
  module Grades
    STRATEGIES = [
      FlexyTablePersistence::Grades::StudentSubjectGrade
    ].freeze

    def self.table_strategy_slug
      'grades'
    end
  end
end
