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
    current_study_year - promotion + 1
  end

  def students_count
    students.count
  end

  def to_s
    "#{current_grade} #{suffix} - #{main_teacher.full_name}"
  end

  private

  def current_study_year
    if Date.today.month > 8
      Date.today.year
    else
      Date.today.year - 1
    end
  end
end
