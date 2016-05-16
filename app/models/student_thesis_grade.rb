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

class StudentThesisGrade < ActiveRecord::Base
  validates(
    :value,
    :semester,
    :student,
    :subject,
    presence: true
  )
  validates(
    :subject_id,
    uniqueness: { scope: [:subject_id, :semester_id] }
  )
  validate :annual_grade_absence

  belongs_to :student
  belongs_to :subject
  belongs_to :semester

  private

  def annual_grade_absence
    if semester && subject && student
      annual_grade = StudentAnnualGrade.find_by(
        student: student,
        subject: subject,
        year: semester.year
      )
      if annual_grade
        errors.add(
          :semester,
          'student already has an annual grade'
        )
      end
    end
  end
end
