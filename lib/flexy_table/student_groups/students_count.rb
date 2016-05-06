module FlexyTable
  module StudentGroups
    class StudentsCount < Base
      def self.strategy_slug
        'students_count'
      end

      def self.strategy_inputs_schema
        {}
      end

      def self.strategy_column
        {
          'id' => 'student_groups_students_counts',
          'label' => 'Numărul elevilor'
        }
      end

      def strategy_data
        student_groups.map do |group|
          [
            group.id,
            group.students.length
          ]
        end
      end
    end
  end
end
