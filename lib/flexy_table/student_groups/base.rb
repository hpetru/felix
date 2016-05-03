module FlexyTable
  module StudentGroups
    class Base < ::FlexyTable::Base
      private

      def student_groups
        StudentGroup.all
      end
    end
  end
end
