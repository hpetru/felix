# == Schema Information
#
# Table name: student_annual_grades
#
#  id         :integer          not null, primary key
#  subject_id :integer          not null
#  value      :float            not null
#  year       :integer          not null
#  student_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  student_annual_grades_uniqueness  (student_id,year,subject_id) UNIQUE
#

require 'rails_helper'

describe StudentAnnualGrade do
  it { should validate_presence_of :value }
  it { should validate_presence_of :year }
  it { should validate_presence_of :student }
  it { should validate_presence_of :subject }
  it { should belong_to :student }
  it { should belong_to :subject }

  describe 'validate if student doesnt have semester grades' do
    context 'valid record' do
      it do
        grade = create(:student_annual_grade)

        expect(grade.valid?).to eq(true)
      end
    end

    context 'invalid record' do
      it do
        grade = build(:student_annual_grade)
        annual_grade = create(
          :student_semester_grade,
          student: grade.student,
          subject: grade.subject,
          semester: create(
            :semester,
            year: grade.year,
            semester_type: 'first_semester'
          )
        )

        expect(grade.valid?).to eq(false)
      end

      it do
        grade = build(:student_annual_grade)
        annual_grade = create(
          :student_thesis_grade,
          student: grade.student,
          subject: grade.subject,
          semester: create(
            :semester,
            year: grade.year,
            semester_type: 'first_semester'
          )
        )

        expect(grade.valid?).to eq(false)
      end
    end
  end
end
