# == Schema Information
#
# Table name: students
#
#  id               :integer          not null, primary key
#  first_name       :string           not null
#  last_name        :string           not null
#  student_group_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_students_on_student_group_id  (student_group_id)
#

require 'rails_helper'

describe Student do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :student_group }
  it { should belong_to :student_group }
  it { should have_many :semester_grades }
  it { should have_many :anual_grades }
  it { should have_many :thesis_grades }
end
