# == Schema Information
#
# Table name: teachers
#
#  id                 :integer          not null, primary key
#  first_name         :string           not null
#  last_name          :string           not null
#  birthday           :date             not null
#  phone              :string
#  degree             :string
#  graduated_from_id  :integer
#  degree_reeval_year :integer
#  retired            :boolean          default("false")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  gender             :string           not null
#  syndicate_member   :boolean          default("false")
#  idnp_token         :string
#

class Teacher < ActiveRecord::Base
  NAME_REGEXP = /\A[^0-9`!@#\$%\^&*+_=]+\z/
  before_save :generate_graduated_from
  before_create :generate_graduated_from
  attr_accessor   :graduated_from_input

  enum degree: {
    doctorate: 'doctorate',
    superior_degree: 'superior_degree',
    first_degree: 'first_degree',
    second_degree: 'second_degree',
    third_degree: 'third_degree'
  }
  enum gender: {
    male: 'male',
    female: 'female'
  }

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
    :first_name,
    :last_name,
    :birthday,
    presence: true
  )

  validates(
    :birthday,
    format: {
      with: /\d{4}\-\d{2}\-\d{2}/
    }
  )

  has_and_belongs_to_many :subjects
  has_many :teaching_subjects
  has_many :student_groups, foreign_key: :main_teacher_id, class_name: StudentGroup
  belongs_to :graduated_from, class_name: Institution


  def full_name
    "#{first_name} #{last_name}"
  end

  def degree_display
    I18n.t(
      degree || 'default',
      scope: [
        :activerecord,
        :values,
        :teacher,
        :degree
      ]
    )
  end

  def graduated_from_name
    return graduated_from_input if !graduated_from_input.nil?
    graduated_from.nil? ? nil : graduated_from.name
  end

  def retired_display
    retired ? 'Da' : 'Nu'
  end

  def syndicate_member_display
    syndicate_member ? 'Da' : 'Nu'
  end

  alias :to_s :full_name
  def generate_graduated_from
    return if graduated_from_input.nil?
    if !graduated_from_input.empty?
      inst = Institution.find_or_create_by(name: graduated_from_input)
      self.graduated_from = inst
    else
      self.graduated_from = nil
    end
  end
end
