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
  validates_presence_of :city
  validates_presence_of :street
  belongs_to :city
end
