# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  street     :string           not null
#  city_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Address do
  it { should validate_presence_of :street }
  it { should validate_presence_of :city }

  describe '#display' do
    it do
      city = create(:city)
      address = described_class.new(city: city)

      expect(address.display).to eq(
        "#{address.city.name} - str. #{address.street}"
      )
    end
  end
end
