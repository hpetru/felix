# == Schema Information
#
# Table name: student_grades
#
#  id          :integer          not null, primary key
#  value       :float            not null
#  grade_type  :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  student_id  :integer          not null
#  semester_id :integer          not null
#  subject_id  :integer          not null
#

class StudentGrade < ActiveRecord::Base
  enum grade_type: {
    thesis: 'thesis',
    semester: 'semester'
  }

  belongs_to :subject
  belongs_to :semester
  belongs_to :student

  validates(
    :student,
    :semester,
    :subject,
    :value,
    :grade_type,
    presence: true
  )

  validates :value, numericality: {
    greater_or_equal_to: 1,
    less_than_or_equal_to: 10
  }
end
