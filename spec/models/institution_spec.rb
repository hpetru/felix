# == Schema Information
#
# Table name: institutions
#
#  id   :integer          not null, primary key
#  name :string           not null
#

require 'rails_helper'

describe Institution do
  it { should validate_presence_of :name }
  it { should have_many :students }
  it { should have_many :teachers }
end
