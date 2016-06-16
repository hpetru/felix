# == Schema Information
#
# Table name: institutions
#
#  id   :integer          not null, primary key
#  name :string           not null
#

class Institution < ActiveRecord::Base
  validates_presence_of :name

  has_many :students, foreign_key: :came_from_id
  has_many :teachers, foreign_key: :graduated_from_id

  def display
    name
  end
  alias :to_s :display
end
