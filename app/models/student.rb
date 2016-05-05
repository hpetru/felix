# == Schema Information
#
# Table name: students
#
#  id               :integer          not null, primary key
#  first_name       :string           not null
#  last_name        :string           not null
#  student_group_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_students_on_student_group_id  (student_group_id)
#

class Student < ActiveRecord::Base
  validates(
    :first_name,
    :last_name,
    :student_group,
    presence: true
  )

  belongs_to :student_group
  has_many :semester_grades, class_name: StudentSemesterGrade
  has_many :anual_grades, class_name: StudentAnualGrade
  has_many :thesis_grades, class_name: StudentThesisGrade

  def full_name
    "#{first_name} #{last_name}"
  end
  alias :to_s :full_name
end
