# == Schema Information
#
# Table name: students
#
#  id                  :integer          not null, primary key
#  first_name          :string           not null
#  last_name           :string           not null
#  student_group_id    :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  came_at             :date
#  idnp                :string
#  address_id          :integer
#  address_house       :string
#  address_appartment  :string
#  father_last_name    :string
#  father_first_name   :string
#  father_phone_number :string
#  mother_last_name    :string
#  mother_first_name   :string
#  mother_phone_number :string
#  mother_email        :string
#  gender              :string           not null
#  inside_code_token   :string           not null
#  birthday            :date
#  father_email        :string
#  foreign_language_id :integer
#  came_from_id        :integer
#  nationality_id      :integer          not null
#
# Indexes
#
#  index_students_on_student_group_id  (student_group_id)
#

class Student < ActiveRecord::Base
  enum gender: {
    male: 'male',
    female: 'female'
  }

  validates(
    :first_name,
    :last_name,
    :student_group,
    :inside_code_token,
    :nationality,
    :gender,
    presence: true
  )

  belongs_to :nationality
  belongs_to :student_group
  belongs_to :address
  has_many :semester_grades, class_name: StudentSemesterGrade
  has_many :anual_grades, class_name: StudentAnualGrade
  has_many :thesis_grades, class_name: StudentThesisGrade
  belongs_to :came_from, class_name: Institution
  belongs_to :foreign_language, class_name: Subject
  delegate :main_teacher, to: :student_group

  def full_name
    "#{first_name} #{last_name}"
  end

  alias :to_s :full_name
end
