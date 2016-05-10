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

  describe '#to_s' do
    it do
      main_teacher = create(:teacher)
      group = described_class.new(
        suffix: 'A',
        main_teacher: main_teacher
      )
      allow(group).to receive(:current_grade).
        and_return(9)

      expect(group.to_s).to eq("9 A - #{main_teacher.full_name}")
    end
  end

  describe '#display' do
    it do
      new_time = Time.local(2016, 9, 1, 12, 0, 0)
      Timecop.freeze(new_time)
      group = described_class.new(promotion: 2005, suffix: 'A')
      allow(group).to receive(:current_grade).
        and_return(9)

      expect(group.display).to eq("9 A")
    end
  end
end
