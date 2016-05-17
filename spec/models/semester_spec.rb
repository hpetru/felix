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
  it { should validate_presence_of :study_year }
  it { should validate_presence_of :semester_type }
  it { should have_many :student_thesis_grades }
  it { should have_many :student_semester_grades }
end
