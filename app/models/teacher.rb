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
#  graduated_from     :string
#  degree_reeval_year :integer
#  retired            :boolean          default("false")
#  sindicate_member   :boolean          default("false")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  gender             :string           not null
#

class Teacher < ActiveRecord::Base
  enum degree: {
    'first_degree' => 'first_degree',
    'second_degree' => 'second_degree',
    'third_degree' => 'third_degree',
    'superior_degree' => 'superior_degree'
  }

  validates(
    :first_name,
    :last_name,
    :birthday,
    :degree,
    presence: true
  )

  has_many :teaching_subjects
end
