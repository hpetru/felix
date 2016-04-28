# == Schema Information
#
# Table name: nationalities
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Nationality do
  it { should validate_presence_of :name }
end
