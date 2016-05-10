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

require 'rails_helper'

describe Teacher do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :birthday }
  it { should have_and_belong_to_many :subjects }
  it { should have_many :teaching_subjects }
  it { should have_many :student_groups }
  it { should belong_to :graduated_from }
end
