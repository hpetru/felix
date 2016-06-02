require 'rails_helper'

describe FlexyTable::Grades::StudentSubjectGrade do
  describe '.strategy_slug' do
    it do
      expect(described_class.strategy_slug).to eq(
        'student_subject_grade'
      )
    end
  end

  describe '.strategy_inputs_schema' do
    it do
      expect(described_class.strategy_inputs_schema).to eq(
        'subject_id' => Integer,
        'grade_type' => String,
        'semester_id' => Integer,
        'student_group_id' => Integer
      )
    end
  end

  describe '#strategy_column' do
    it do
      student_group_id = 1
      subject = create(:subject)
      semester = create(:semester)
      grade_type = 'thesis'
      strategy = described_class.new(
        'subject_id' => subject.id,
        'grade_type' => grade_type,
        'semester_id' => semester.id,
        'student_group_id' => student_group_id
      )

      expect(strategy.strategy_column).to eq(
        'id' => [
          'grades_student_subject_grade',
          subject.id,
          semester.id,
          grade_type
        ].join('_'),
        'label' => "#{subject.name} (#{semester.semester_type_label}) T",
        'editable' => true
      )
    end
  end

  describe '#strategy_data' do
    it do
      grade_type = 'thesis'
      subject = create(:subject)
      subject_2 = create(:subject)
      student_group = create(:student_group)
      semester = create(:semester)
      students = [
        create(
          :student,
          student_group: student_group,
        ),
        create(
          :student,
          student_group: student_group
        ),
        create(
          :student,
          student_group: student_group
        )
      ]
      create(
        :student_grade,
        subject: subject,
        semester: semester,
        student: students[0],
        grade_type: grade_type,
        value: 9
      )
      create(
        :student_grade,
        subject: subject,
        semester: semester,
        student: students[1],
        grade_type: grade_type,
        value: 8
      )
      create(
        :student_grade,
        subject: subject,
        student: students[0],
        semester: semester,
        grade_type: 'semester',
        value: 9.5
      )
      create(
        :student_grade,
        subject: subject_2,
        student: students[0],
        semester: semester,
        grade_type: grade_type,
        value: 9.7
      )
      strategy = described_class.new(
        'subject_id' => subject.id,
        'grade_type' => grade_type,
        'semester_id' => semester.id,
        'student_group_id' => student_group.id
      )

      expect(strategy.strategy_data).to match_array(
        [
          [
            students[0].id,
            9.0
          ],
          [
            students[1].id,
            8.0
          ],
          [
            students[2].id,
            nil
          ]
        ]
      )
    end
  end
end
