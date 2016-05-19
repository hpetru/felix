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

class Semester < ActiveRecord::Base
  enum semester_type: {
    first_semester: 'first_semester',
    second_semester: 'second_semester'
  }

  validates(
    :year,
    :semester_type,
    presence: true
  )
end
