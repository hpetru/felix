module FlexyTable
  module StudentGroups
    class MainTeacherName < Base
      def self.strategy_slug
        'main_teacher_name'
      end

      def self.strategy_inputs_schema
        {}
      end

      def self.strategy_column
        {
          'label': 'Diriginte'
        }
      end

      def strategy_data
        student_groups.map do |group|
          [
            group.id,
            group.main_teacher.full_name
          ]
        end
      end
    end
  end
end
