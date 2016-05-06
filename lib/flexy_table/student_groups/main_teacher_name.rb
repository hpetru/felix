module FlexyTable
  module StudentGroups
    class MainTeacherName < StudentGroups::Base
      def self.strategy_slug
        'main_teacher_name'
      end

      def self.strategy_inputs_schema
        {}
      end

      def strategy_column
        {
          'id' => 'student_groups_main_teacher_name',
          'label' => 'Diriginte'
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
