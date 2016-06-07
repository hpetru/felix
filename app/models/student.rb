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
#  idnp_token          :string
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
#  born_at             :date             not null
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
  INSIDE_CODE_REGEX = /[A-Z]\-\d{4}/
  validates(
    :first_name,
    :last_name,
    :student_group,
    :inside_code_token,
    :nationality,
    :born_at,
    :gender,
    presence: true
  )

  validates(
    :first_name,
    :last_name,
    length: {
      minimum: 3,
      maximum: 20,
    },
    format: {
      with: /\A[^0-9`!@#\$%\^&*+_=]+\z/
    }
  )

  validates(
    :idnp_token,
    allow_blank: true,
    length: {
      minimum: 13,
      maximum: 13,
    },
    format: {
      with: /\d*/
    },
    uniqueness: true
  )

  validates(
    :inside_code_token,
    format: { with: INSIDE_CODE_REGEX },
    uniqueness: true
  )

  belongs_to :nationality
  belongs_to :student_group
  belongs_to :address
  belongs_to :came_from, class_name: Institution
  belongs_to :foreign_language, class_name: Subject
  delegate :main_teacher, to: :student_group

  def self.current
    joins(:student_group).where(
      '? - promotion + 1 <= 12',
      StudentGroup.current_study_year
    )
  end

  def self.graduate
    joins(:student_group).where(
      '? - promotion + 1 > 12',
      StudentGroup.current_study_year
    )
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  alias :to_s :full_name

  def age
    now = Date.current
    delta = born_at.change(year: now.year) > now ? 1 : 0
    now.year - born_at.year - delta
  end

  def gender_display
    I18n.t gender, scope: [
      :activerecord,
      :values,
      :student,
      :gender
    ]
  end
end
