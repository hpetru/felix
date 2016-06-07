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

class StudentGroup < ActiveRecord::Base
  STUDY_YEAR_START = Date.new(Date.today.year, 8, 25)
  enum profile_slug: {
    real: 'real',
    humanitarian: 'humanitarian'
  }

  validates(
    :promotion,
    :suffix,
    :main_teacher,
    presence: true
  )

  validates :suffix, length: { maximum: 1 }
  has_many :students
  belongs_to :main_teacher, class_name: Teacher
  has_many :students

  def current_grade
    self.class.current_study_year - promotion + 1
  end

  def current_grade_safe
    current_grade <= 12 ? current_grade : '[A] 12'
  end

  def students_count
    students.count
  end

  def to_s
    "#{current_grade_safe} #{suffix} - #{main_teacher.full_name}"
  end

  def display
    "#{current_grade_safe} #{suffix}"
  end

  def profile_display
    I18n.t profile_slug, scope: [
      :activerecord,
      :values,
      :student_group,
      :profile_slug
    ]
  end

  def self.current
    where(
      '? - promotion + 1 <= 12',
      current_study_year
    )
  end

  def self.graduate
    where(
      '? - promotion + 1 > 12',
      current_study_year
    )
  end

  def self.current_study_year
    if Date.today > STUDY_YEAR_START
      Date.today.year
    else
      Date.today.year - 1
    end
  end
end
