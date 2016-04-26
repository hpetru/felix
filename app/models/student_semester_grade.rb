# == Schema Information
#
# Table name: student_semester_grades
#
#  id          :integer          not null, primary key
#  value       :float            not null
#  subject_id  :integer          not null
#  student_id  :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  semester_id :integer          not null
#

class StudentSemesterGrade < ActiveRecord::Base
  validates(
    :value,
    :subject,
    :student,
    :semester,
    presence: true
  )

  belongs_to :student
  belongs_to :subject
  belongs_to :semester
end
