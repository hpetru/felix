module FlexyTable
  module StudentGroups
    class Suffix < Base
      def self.strategy_slug
        'suffix'
      end

      def self.strategy_inputs_schema
        {}
      end

      def self.strategy_column
        {
          'id' => 'student_groups_suffix',
          'label' => 'Paralela'
        }
      end

      def strategy_data
        student_groups.map do |group|
          [
            group.id,
            group.suffix
          ]
        end
      end
    end
  end
end
