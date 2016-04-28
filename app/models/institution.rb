# == Schema Information
#
# Table name: institutions
#
#  id   :integer          not null, primary key
#  name :string           not null
#

class Institution < ActiveRecord::Base
  validates_presence_of :name
end
