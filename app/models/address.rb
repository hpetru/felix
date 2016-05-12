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

class Address < ActiveRecord::Base
  validates(
    :city,
    :street,
    presence: true
  )
  belongs_to :city

  def display_name
    "#{city.name} - #{street}"
  end
end
