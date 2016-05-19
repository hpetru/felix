require 'rails_helper'

feature 'Flexy table' do
  class GradeBuilder
    def initialize(inputs)
      @inputs = inputs
    end

    def perform
      grade.value = grade_value
      grade.save!
    end

    private

    def grade
      @grade ||= fetch_grade
    end

    def student
      Student.find(@inputs['student_id'])
    end

    def subject
      Subject.find(@inputs['subject_id'])
    end

    def semester
      Semester.find(
        @inputs['grade_inputs']['semester_id']
      )
    end

    def grade_value
      @inputs['grade_value']
    end

    def fetch_grade
      case @inputs['grade_type']
      when 'semester_grade'
        StudentSemesterGrade.find_or_initialize_by(
          student: student,
          subject: subject,
          semester: semester
        )
      when 'thesis_grade'
        StudentThesisGrade.find_or_initialize_by(
          student: student,
          subject: subject,
          semester: semester
        )
      else
        raise
      end
    end
  end

  context 'semester grade' do
    before do
      @student = create(:student)
      @subject = create(:subject)
      @semester = create(:semester)
      @inputs = {
        'student_id' => @student.id,
        'subject_id' => @subject.id,
        'grade_value' => 9.4,
        'grade_type' => 'semester_grade',
        'grade_inputs' => {
          'semester_id' => @semester.id
        }
      }
    end

    it 'create a new grade' do
      builder = GradeBuilder.new(@inputs)
      builder.perform
      grade = StudentSemesterGrade.first

      expect(StudentSemesterGrade.count).to eq(1)
      expect(grade.value).to eq(9.4)
      expect(grade.student).to eq(@student)
      expect(grade.subject).to eq(@subject)
    end

    it 'update existent grade' do
      grade = create(
        :student_semester_grade,
        student: @student,
        semester: @semester,
        subject: @subject,
        value: 8.6
      )
      builder = GradeBuilder.new(@inputs)
      builder.perform
      grade.reload

      expect(StudentSemesterGrade.count).to eq(1)
      expect(grade.value).to eq(9.4)
    end
  end

  context 'thesis grade' do
    before do
      @student = create(:student)
      @subject = create(:subject)
      @semester = create(:semester)
      @inputs = {
        'student_id' => @student.id,
        'subject_id' => @subject.id,
        'grade_value' => 9,
        'grade_type' => 'thesis_grade',
        'grade_inputs' => {
          'semester_id' => @semester.id
        }
      }
    end

    it 'create a new grade' do
      builder = GradeBuilder.new(@inputs)
      builder.perform
      grade = StudentThesisGrade.first

      expect(StudentThesisGrade.count).to eq(1)
      expect(grade.value).to eq(9)
      expect(grade.student).to eq(@student)
      expect(grade.subject).to eq(@subject)
    end

    it 'update existent grade' do
      grade = create(
        :student_thesis_grade,
        student: @student,
        semester: @semester,
        subject: @subject,
        value: 8
      )
      builder = GradeBuilder.new(@inputs)
      builder.perform
      grade.reload

      expect(StudentThesisGrade.count).to eq(1)
      expect(grade.value).to eq(9)
    end
  end
end
