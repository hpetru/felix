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

class StudentThesisGrade < ActiveRecord::Base
  validates(
    :value,
    :semester,
    :student,
    :subject,
    presence: true
  )

  belongs_to :student
  belongs_to :subject
  belongs_to :semester
end
