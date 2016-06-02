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
  SEMESTER_MAPPING = {
    'first_semester' => 'I',
    'second_semester' => 'II'
  }

  enum semester_type: {
    first_semester: 'first_semester',
    second_semester: 'second_semester'
  }

  validates(
    :year,
    :semester_type,
    presence: true
  )

  def display_label
    "#{year} - #{semester_type_label}"
  end

  def semester_type_label
    SEMESTER_MAPPING.fetch(
      semester_type
    )
  end
end
