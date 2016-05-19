# == Schema Information
#
# Table name: subjects
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Subject do
  it { should validate_presence_of :name }

  describe '#all_as_selectable' do
    it do
      subjects = [
        described_class.create(name: 'Limba română'),
        described_class.create(name: 'Biologia'),
      ]
      expect(described_class.all_as_selectable).to eq(
        subjects.map { |s| [s.name, s.id] }
      )
    end
  end
end
