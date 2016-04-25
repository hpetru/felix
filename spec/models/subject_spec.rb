# == Schema Information
#
# Table name: subjects
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Subject do
  it { should validate_presence_of :name }
end
