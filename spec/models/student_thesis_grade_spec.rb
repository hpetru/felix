# == Schema Information
#
# Table name: student_thesis_grades
#
#  id          :integer          not null, primary key
#  student_id  :integer          not null
#  value       :integer          not null
#  subject_id  :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  semester_id :integer          not null
#
# Indexes
#
#  student_thesis_grades_uniqueness  (student_id,semester_id,subject_id) UNIQUE
#

require 'rails_helper'

describe StudentThesisGrade do
  it { should validate_presence_of :student }
  it { should validate_presence_of :subject }
  it { should validate_presence_of :value }
  it { should validate_presence_of :semester }
  it { should belong_to :subject }
  it { should belong_to :student }
  it { should belong_to :semester }

  describe 'validate if student doesnt have annual grade' do
    context 'valid record' do
      it do
        grade = create(:student_thesis_grade)

        expect(grade.valid?).to eq(true)
      end
    end

    context 'invalid record' do
      it do
        grade = build(:student_thesis_grade)
        annual_grade = create(
          :student_annual_grade,
          student: grade.student,
          subject: grade.subject,
          year: grade.semester.year
        )

        expect(grade.valid?).to eq(false)
      end
    end
  end
end
