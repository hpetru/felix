# == Schema Information
#
# Table name: student_thesis_grades
#
#  id          :integer          not null, primary key
#  student_id  :integer          not null
#  value       :integer          not null
#  subject_id  :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  semester_id :integer          not null
#

require 'rails_helper'

describe StudentThesisGrade do
  it { should validate_presence_of :student }
  it { should validate_presence_of :subject }
  it { should validate_presence_of :value }
  it { should validate_presence_of :semester }
  it { should belong_to :subject }
  it { should belong_to :student }
  it { should belong_to :semester }
end
