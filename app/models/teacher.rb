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
    first_degree: 'first_degree',
    second_degree: 'second_degree',
    third_degree: 'third_degree',
    superior_degree: 'superior_degree'
  }
  enum gender: {
    male: 'male',
    female: 'female'
  }

  validates(
    :first_name,
    :last_name,
    :birthday,
    presence: true
  )
  has_and_belongs_to_many :subjects, through: :subjects
  has_many :teaching_subjects
  belongs_to :graduated_from, class_name: Institution.to_s


  def full_name
    "#{first_name} #{last_name}"
  end
  alias :to_s :full_name
end
