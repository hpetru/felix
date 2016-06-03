module FlexyTable
  module Grades
    class Base < ::FlexyTable::Base
      def self.strategy_inputs_schema
        {
          'student_group_id' => Integer
        }
      end

      private

      def students
        Student.where(student_group: student_group).
          order_by_name
      end

      def student_group
        StudentGroup.find(
          strategy_inputs['student_group_id']
        )
      end
    end
  end
end
