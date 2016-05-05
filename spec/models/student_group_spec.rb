# == Schema Information
#
# Table name: student_groups
#
#  id              :integer          not null, primary key
#  promotion       :integer          not null
#  suffix          :string           not null
#  profile_slug    :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  main_teacher_id :integer          not null
#

require 'rails_helper'

describe StudentGroup do
  it { should validate_presence_of :promotion }
  it { should validate_presence_of :suffix }
  it { should validate_presence_of :profile_slug }
  it { should validate_presence_of :main_teacher }
  it { should belong_to :main_teacher }
  it { should have_many :students }

  describe '#current_grade' do
    it do
      new_time = Time.local(2016, 9, 1, 12, 0, 0)
      Timecop.freeze(new_time)
      group = described_class.new(promotion: 2005)

      expect(group.current_grade).to eq(
        12
      )
    end
  end
end
