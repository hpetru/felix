require 'rails_helper'

feature 'Student grades' do
  class SemesterGradeCalc
    def initialize(student, semester, subject)
      @student = student
      @semester = semester
      @subject = subject
    end

    def perform
      if thesis_grade
        (semester_grade_value + thesis_grade_value) / 2.0
      else
        semester_grade_value
      end
    end

    private

    def semester_grade_value
      semester_grade.value
    end

    def thesis_grade_value
      if thesis_grade
        thesis_grade.value
      end
    end

    def thesis_grade
      @thesis_grade ||= StudentThesisGrade.find_by(
        student: @student,
        semester: @semester,
        subject: @subject
      )
    end

    def semester_grade
      @semester_grade ||= StudentSemesterGrade.find_by!(
        student: @student,
        semester: @semester,
        subject: @subject
      )
    end
  end

  class AnnualGrageCalc
    def initialize(student, year, subject)
      @student = student
      @subject = subject
      @year = year
    end

    def perform
      if annual_grade
        annual_grade.value
      else
        semester_grade_calcs.map(&:perform).
          inject(:+) / semester_grade_calcs.count.to_f
      end
    end

    private

    def annual_grade
      @annual_grade ||= StudentAnnualGrade.find_by(
        student: @student,
        year: @year,
        subject: @subject
      )
    end

    def semesters
      Semester.where(year: @year)
    end

    def semester_grade_calcs
      @semester_grade_calcs ||= semesters.map do |semester|
        SemesterGradeCalc.new(
          @student,
          semester,
          @subject
        )
      end
    end
  end

  before do
    @year = 2015
    @first_semester = create(
      :semester,
      year: @year,
      semester_type: 'first_semester'
    )
    @second_semester = create(
      :semester,
      year: @year,
      semester_type: 'second_semester'
    )
    @student = create(:student)
    @subject = create(:subject)
    semester_grades = [
      create(
        :student_semester_grade,
        value: 9,
        student: @student,
        semester: @first_semester,
        subject: @subject
      ),
      create(
        :student_semester_grade,
        value: 10,
        student: @student,
        semester: @second_semester,
        subject: @subject
      ),
      create(
        :student_thesis_grade,
        value: 8,
        student: @student,
        semester: @first_semester,
        subject: @subject
      )
    ]
  end

  context 'calculez nota simestriala' do
    scenario 'cind exista teza' do
      calc = SemesterGradeCalc.new(
        @student,
        @first_semester,
        @subject
      )

      expect(calc.perform).to eq(8.5)
    end

    scenario 'cind nu exista teza' do
      calc = SemesterGradeCalc.new(
        @student,
        @second_semester,
        @subject
      )

      expect(calc.perform).to eq(10)
    end
  end

  context 'calculez nota anuala' do
    scenario 'cind nu exista nota anuala' do
      calc = AnnualGrageCalc.new(
        @student,
        @year,
        @subject
      )

      expect(calc.perform).to eq(9.25)
    end

    scenario 'cind exista nota anuala' do
      annual_grade = build(
        :student_annual_grade,
        value: 8.4,
        year: @year,
        subject: @subject,
        student: @student
      ).save(validate: false)
      calc = AnnualGrageCalc.new(
        @student,
        @year,
        @subject
      )

      expect(calc.perform).to eq(8.4)
    end
  end
end
