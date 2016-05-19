# == Schema Information
#
# Table name: teachers
#
#  id                 :integer          not null, primary key
#  first_name         :string           not null
#  last_name          :string           not null
#  birthday           :date             not null
#  phone              :string
#  degree             :string
#  graduated_from_id  :integer
#  degree_reeval_year :integer
#  retired            :boolean          default("false")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  gender             :string           not null
#  syndicate_member   :boolean          default("false")
#  idnp_token         :string
#

require 'rails_helper'

describe Teacher do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :birthday }
  it { should validate_length_of(:first_name).is_at_least(3) }
  it { should validate_length_of(:first_name).is_at_most(20) }
  it { should validate_length_of(:last_name).is_at_least(3) }
  it { should validate_length_of(:last_name).is_at_most(20) }
  it { should have_and_belong_to_many :subjects }
  it { should have_many :teaching_subjects }
  it { should have_many :student_groups }
  it { should belong_to :graduated_from }
  it { should_not allow_value('Miihd3j948').for(:first_name) }
  it { should_not allow_value('23iojd,_*&!').for(:last_name) }

  describe '#degree_display' do
    it do
      teacher = create(:teacher)
      expect(teacher.degree_display).to eq(
        I18n.t teacher.degree, scope: [
          :activerecord,
          :values,
          :teacher,
          :degree
        ]
      )
    end
  end
end
