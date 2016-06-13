module FlexyTable
  module Grades
    class StudentSubjectGrade < Grades::Base
      GRADE_LABELS = {
        'thesis' => 'T',
        'semester' => 'S'
      }

      def self.strategy_slug
        'student_subject_grade'
      end

      def self.strategy_inputs_schema
        {
          'subject_id' => Integer,
          'grade_type' => String,
          'semester_id' => Integer,
          'student_group_id' => Integer
        }
      end

      def strategy_data
        students.map do |student|
          [
            student.id,
            grades[student.id]
          ]
        end
      end

      def strategy_column
        {
          'id' => [
            'grades_student_subject_grade',
            subject.id,
            semester.id,
            strategy_inputs['grade_type']
          ].join('_'),
          'label' => "#{subject.name} (#{semester.semester_type_label}) #{grade_type_label}",
          'editable' => true
        }
      end

      private

      def subject
        @subject ||= Subject.find(
          strategy_inputs['subject_id']
        )
      end

      def semester
        @semester ||= Semester.find(
          strategy_inputs['semester_id']
        )
      end

      def grades
        @grades ||= StudentGrade.joins(:student).
          merge(students).
          where(grade_type: strategy_inputs['grade_type']).
          where(subject: subject, semester: semester).
          each_with_object({}) { |grade, memo| memo.merge!(grade.student_id => grade.value) }
      end

      def grade_type_label
        if strategy_inputs['grade_type'] == 'thesis'
          'T'
        end
      end
    end
  end
end
