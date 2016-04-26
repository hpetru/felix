# == Schema Information
#
# Table name: student_groups
#
#  id           :integer          not null, primary key
#  promotion    :integer          not null
#  suffix       :string           not null
#  profile_slug :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class StudentGroup < ActiveRecord::Base
  enum profile_slug: {
    real: 'real',
    humanitarian: 'humanitarian'
  }

  validates(
    :promotion,
    :suffix,
    presence: true
  )

  validates :suffix, length: { maximum: 1 }
end
