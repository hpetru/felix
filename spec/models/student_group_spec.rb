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

require 'rails_helper'

describe StudentGroup do
  it { should validate_presence_of :promotion }
  it { should validate_presence_of :suffix }
end
