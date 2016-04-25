# == Schema Information
#
# Table name: student_groups
#
#  id           :integer          not null, primary key
#  promotion    :integer          not null
#  suffix       :string           not null
#  profile_slug :string           not null
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
    :profile_slug,
    presence: true
  )
end
