# == Schema Information
#
# Table name: semesters
#
#  id            :integer          not null, primary key
#  year          :integer          not null
#  semester_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

describe Semester do
  it { should validate_presence_of :year }
  it { should validate_presence_of :semester_type }
end
