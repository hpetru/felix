# == Schema Information
#
# Table name: subjects
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Subject < ActiveRecord::Base
  validates :name, presence: true

  def self.all_as_selectable
    all.order(:name).map { |x| [x.name, x.id] }
  end

  def display
    name
  end

  alias :to_s :display
end
