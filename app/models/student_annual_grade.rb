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

class StudentAnnualGrade < ActiveRecord::Base
  validates(
    :value,
    :year,
    :subject,
    :student,
    presence: true
  )
  validates(
    :subject_id,
    uniqueness: { scope: [:student_id, :year] }
  )
  validate :semester_grades_absence

  belongs_to :student
  belongs_to :subject

  private

  def semester_grades_absence
    if subject && student && year
      semesters = Semester.where(year: year)

      semester_grades = StudentSemesterGrade.where(
        student: student,
        semester: semesters,
        subject: subject
      )

      thesis_grades = StudentThesisGrade.where(
        student: student,
        semester: semesters,
        subject: subject
      )

      if semester_grades.exists?
        errors.add(
          :year,
          'semester grades already exists'
        )
      elsif thesis_grades.exists?
        errors.add(
          :year,
          'thesis grades already exists'
        )
      end
    end
  end
end
