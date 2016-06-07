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
#  idnp_token          :string
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
#  born_at             :date             not null
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
  it { should validate_presence_of :born_at }
  it { should belong_to :nationality }
  it { should belong_to :foreign_language }
  it { should belong_to :student_group }
  it { should belong_to :came_from }
  it { should validate_length_of(:first_name).is_at_least(3) }
  it { should validate_length_of(:first_name).is_at_most(20) }
  it { should validate_length_of(:last_name).is_at_least(3) }
  it { should validate_length_of(:last_name).is_at_most(20) }
  it { should validate_length_of(:idnp_token).is_at_least(13) }
  it { should validate_length_of(:idnp_token).is_at_most(13) }
  it { should_not allow_value('Dorin32;').for(:first_name) }
  it { should_not allow_value('Mih3io4j_&d,').for(:last_name) }
  it { should_not allow_value('8923983jska').for(:idnp_token) }
  it { should_not allow_value('B-023').for(:inside_code_token) }
  it { should allow_value('B-0234').for(:inside_code_token) }

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

  describe '#age' do
    it do
      student = described_class.new(
        born_at: Date.parse('1996-07-15')
      )
      new_time = Time.local(2016, 07, 16, 12, 0, 0)
      Timecop.freeze(new_time)

      expect(student.age).to eq 20
    end
  end

  describe '#gender_display' do
    it do
      student = create(:student)
      expect(student.gender_display).to eq(
        I18n.t student.gender, scope: [
          :activerecord,
          :values,
          :student,
          :gender
        ]
      )
    end
  end
end
