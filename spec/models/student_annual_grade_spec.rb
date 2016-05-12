# == Schema Information
#
# Table name: student_annual_grades
#
#  id         :integer          not null, primary key
#  subject_id :integer          not null
#  value      :float            not null
#  year       :integer          not null
#  student_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe StudentAnnualGrade do
  it { should validate_presence_of :value }
  it { should validate_presence_of :year }
  it { should validate_presence_of :student }
  it { should validate_presence_of :subject }
  it { should belong_to :student }
  it { should belong_to :subject }
end
