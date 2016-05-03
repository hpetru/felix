module FlexyTable
  module StudentGroups
    class CurrentGrade < StudentGroups::Base
      def self.strategy_slug
        'current_grade'
      end

      def self.strategy_inputs_schema
        {}
      end

      def strategy_column
        {
          'id' => 'student_groups_current_grade',
          'label' => 'Clasa curentă'
        }
      end

      def strategy_data
        student_groups.map do |student_group|
          [
            student_group.id,
            student_group.current_grade
          ]
        end
      end
    end
  end
end
