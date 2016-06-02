module FlexyTablePersistence
  module Grades
    class StudentSubjectGrade < Base
      def self.strategy_slug
        'student_subject_grade'
      end

      def self.strategy_inputs_schema
        {
          'value' => Float,
          'row_id' => Integer,
          'grade_type' => String,
          'subject_id' => Integer,
          'semester_id' => Integer
        }
      end

      def save
        grade = find_grade
        grade.value = value
        grade.save!
      end

      private

      def find_grade
        StudentGrade.find_or_initialize_by(
          grade_type: grade_type,
          student: student,
          subject: subject,
          semester: semester,
        )
      end

      def student
        Student.find(strategy_inputs['row_id'])
      end

      def subject
        Subject.find(strategy_inputs['subject_id'])
      end

      def semester
        Semester.find(strategy_inputs['semester_id'])
      end

      def grade_type
        strategy_inputs['grade_type']
      end

      def value
        strategy_inputs['value']
      end
    end
  end
end
