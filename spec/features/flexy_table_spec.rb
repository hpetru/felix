require 'rails_helper'

feature 'Flexy table' do
  class Builder
    def initialize(inputs)
      @inputs = inputs
    end

    def perform
      StudentSemesterGrade.create!(
        student: student,
        subject: subject,
        value: @inputs['grade_value'],
        semester: semester
      )
    end

    private

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
  end

  it 'semester grade' do
    student = create(:student)
    subject = create(:subject)
    semester = create(:semester)
    inputs = {
      'student_id' => student.id,
      'subject_id' => subject.id,
      'grade_value' => 10,
      'grade_type' => 'semester_grade',
      'grade_inputs' => {
        'semester_id' => semester.id
      }
    }
    b = Builder.new(inputs)
    b.perform
    grade = StudentSemesterGrade.first

    expect(StudentSemesterGrade.count).to eq(1)
  end
end
