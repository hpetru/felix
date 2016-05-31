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

  describe '#display_label' do
    it do
      semester = create(
        :semester,
        year: 2015,
        semester_type: 'first_semester'
      )

      expect(semester.display_label).to eq(
        '2015 - I'
      )
    end
  end
end
