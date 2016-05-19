# == Schema Information
#
# Table name: student_grades
#
#  id          :integer          not null, primary key
#  value       :float            not null
#  grade_type  :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  student_id  :integer          not null
#  semester_id :integer          not null
#  subject_id  :integer          not null
#

require 'rails_helper'

describe StudentGrade do
  it { should belong_to :student }
  it { should belong_to :semester }
  it { should belong_to :subject }
  it { should validate_presence_of :value }
  it { should validate_presence_of :grade_type }
end
