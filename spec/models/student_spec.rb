# == Schema Information
#
# Table name: students
#
#  id                  :integer          not null, primary key
#  first_name          :string           not null
#  last_name           :string           not null
#  student_group_id    :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  came_at             :date
#  idnp                :string
#  address_id          :integer
#  address_house       :string
#  address_appartment  :string
#  father_last_name    :string
#  father_first_name   :string
#  father_phone_number :string
#  mother_last_name    :string
#  mother_first_name   :string
#  mother_phone_number :string
#  mother_email        :string
#  gender              :string           not null
#  inside_code_token   :string           not null
#  birthday            :date
#  father_email        :string
#  foreign_language_id :integer
#  came_from_id        :integer
#  nationality_id      :integer          not null
#
# Indexes
#
#  index_students_on_student_group_id  (student_group_id)
#

require 'rails_helper'

describe Student do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :student_group }
  it { should validate_presence_of :inside_code_token }
  it { should validate_presence_of :nationality }
  it { should validate_presence_of :gender }
  it { should belong_to :nationality }
  it { should belong_to :foreign_language }
  it { should belong_to :student_group }
  it { should have_many :semester_grades }
  it { should have_many :anual_grades }
  it { should have_many :thesis_grades }
  it { should belong_to :came_from }

  describe '#full_name' do
    it do
      student = described_class.new(
        first_name: 'Ion',
        last_name: 'Babuc'
      )

      expect(student.full_name).to eq(
        'Ion Babuc'
      )
    end
  end
end
