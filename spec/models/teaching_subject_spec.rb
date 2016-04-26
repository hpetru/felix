# == Schema Information
#
# Table name: teaching_subjects
#
#  id               :integer          not null, primary key
#  teacher_id       :integer          not null
#  student_group_id :integer          not null
#  subject_id       :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

describe TeachingSubject do
  it { should validate_presence_of :subject }
  it { should validate_presence_of :teacher }
  it { should validate_presence_of :student_group }
  it { should belong_to :subject }
  it { should belong_to :teacher }
  it { should belong_to :student_group }
end
