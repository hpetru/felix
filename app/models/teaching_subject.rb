# == Schema Information
#
# Table name: teaching_subjects
#
#  id               :integer          not null, primary key
#  teacher_id       :integer          not null
#  student_group_id :integer          not null
#  subject_id       :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class TeachingSubject < ActiveRecord::Base
  validates(
    :teacher,
    :subject,
    :student_group,
    presence: true
  )

  belongs_to :teacher
  belongs_to :subject
  belongs_to :student_group
end
