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
  NAME_REGEXP = /\A[^0-9`!@#\$%\^&*+_=]+\z/
  validate :address_validation
  before_save :generate_address, :generate_came_from
  before_create :generate_address, :generate_came_from

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
      with: NAME_REGEXP
    }
  )

  validates(
    :mother_last_name,
    :mother_first_name,
    :father_last_name,
    :father_first_name,
    allow_blank: true,
    length: {
      minimum: 3,
      maximum: 20,
    },
    format: {
      with: NAME_REGEXP
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
      with: /\d{13}/
    },
    uniqueness: true
  )

  validates(
    :born_at,
    format: {
      with: /\d{4}\-\d{2}\-\d{2}/
    }
  )

  validates(
    :father_phone_number,
    :mother_phone_number,
    allow_blank: true,
    length: {
      minimum: 9,
      maximum: 13,
    },
    format: {
      with: /\d{9,13}/
    }
  )

  validates(
    :inside_code_token,
    format: { with: INSIDE_CODE_REGEX },
    length: {
      minimum: 7,
      maximum: 7,
    },
    uniqueness: true
  )

  def address_validation
    return if city_input.nil? or street_input.nil?
    if !city_input.empty? and street_input.empty?
      errors.add(:street_input, 'Strada este obligatorie în caz că este introdus orașul')
    elsif !street_input.empty? and city_input.empty?
      errors.add(:city_input, 'Orașul este obligatoriu în caz că este introdusă strada')
    end
  end

  belongs_to :nationality
  belongs_to :student_group
  belongs_to :address
  belongs_to :came_from, class_name: Institution
  belongs_to :foreign_language, class_name: Subject
  delegate :main_teacher, to: :student_group
  delegate :city, to: :address, allow_nil: true

  attr_accessor   :street_input, :city_input, :came_from_input
  def self.order_by_name
    order(
      last_name: :asc,
      first_name: :asc
    )
  end

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
    "#{last_name} #{first_name}"
  end

  alias :to_s :full_name

  def age
    now = Date.current
    delta = born_at.change(year: now.year) > now ? 1 : 0
    now.year - born_at.year - delta
  end

  def came_from_name
    return came_from_input if !came_from_input.nil?
    came_from.nil? ? nil : came_from.name
  end

  def city_name
    return city_input if !city_input.nil?
    city.nil? ? nil : city.name
  end

  def street_name
    return street_input if !street_input.nil?
    address.nil? ? nil : address.street
  end

  def gender_display
    I18n.t gender, scope: [
      :activerecord,
      :values,
      :student,
      :gender
    ]
  end

  private

  def generate_came_from
    return if came_from_input.nil?
    if !came_from_input.empty?
      inst = Institution.find_or_create_by(name: came_from_input)
      self.came_from = inst
    else
      self.came_from = nil
    end
  end

  def generate_address
    return if city_input.nil? or street_input.nil?
    if !street_input.empty? and !city_input.empty?
      city = City.find_or_create_by(name: city_input)
      self.address = Address.find_or_create_by(street: street_input, city_id: city.id)
    else
      self.address = nil
    end
  end
end
