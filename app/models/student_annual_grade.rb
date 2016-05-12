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

class StudentAnnualGrade < ActiveRecord::Base
  validates(
    :value,
    :year,
    :subject,
    :student,
    presence: true
  )

  belongs_to :student
  belongs_to :subject
end
