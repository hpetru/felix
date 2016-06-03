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
      with: /\A[^0-9`!@#\$%\^&*+_=]+\z/
    }
  )

  validates(
    :first_name,
    :last_name,
    :birthday,
    presence: true
  )

  has_and_belongs_to_many :subjects
  has_many :teaching_subjects
  has_many :student_groups, foreign_key: :main_teacher_id, class_name: StudentGroup
  belongs_to :graduated_from, class_name: Institution


  def full_name
    "#{first_name} #{last_name}"
  end

  def degree_display
    I18n.t degree, scope: [
      :activerecord,
      :values,
      :teacher,
      :degree
    ] if degree
  end

  alias :to_s :full_name
end
