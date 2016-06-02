require 'rails_helper'

describe FlexyTablePersistence::Grades::StudentSubjectGrade do
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
        'value' => Float,
        'row_id' => Integer,
        'grade_type' => String,
        'subject_id' => Integer,
        'semester_id' => Integer
      )
    end
  end

  describe '#save' do
    before do
      @subject = create(:subject)
      @semester = create(:semester)
      @student = create(:student)
      @strategy_inputs = {
        'value' => '8',
        'row_id' => @student.id,
        'grade_type' => 'semester',
        'subject_id' => @subject.id,
        'semester_id' => @semester.id
      }
    end

    it 'create a new grade' do
      strategy = described_class.new(@strategy_inputs)
      strategy.save
      student_grade = StudentGrade.first

      expect(StudentGrade.count).to eq 1
      expect(student_grade.value).to eq 8
    end

    it 'update existent grade' do
      create(
        :student_grade,
        value: 10,
        grade_type: 'semester',
        student: @student,
        semester: @semester,
        subject: @subject
      )
      strategy = described_class.new(@strategy_inputs)
      strategy.save
      student_grade = StudentGrade.first

      expect(StudentGrade.count).to eq 1
      expect(student_grade.value).to eq 8
    end
  end
end
