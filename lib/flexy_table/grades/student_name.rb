module FlexyTable
  module Grades
    class StudentName < Grades::Base
      def self.strategy_slug
        'student_name'
      end

      def strategy_data
        students.map do |student|
          [
            student.id,
            student.full_name
          ]
        end
      end

      def strategy_column
        {
          'id' => 'grades_student_name',
          'label' => 'Nume student'
        }
      end
    end
  end
end
