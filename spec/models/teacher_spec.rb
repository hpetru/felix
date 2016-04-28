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

require 'rails_helper'

describe Teacher do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :birthday }
  it { should validate_presence_of :degree }
  it { should have_many :teaching_subjects }
end
