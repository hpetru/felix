# == Schema Information
#
# Table name: flexy_memory_tables
#
#  id                    :integer          not null, primary key
#  table_strategy_slug   :string           not null
#  column_input_settings :jsonb            default("{}"), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'rails_helper'

describe FlexyMemory::Table do
  it do
    should validate_inclusion_of(:table_strategy_slug).
      in_array(FlexyTable.table_strategy_slugs)
  end

  it { should have_many :columns }

  describe '.fetch_or_create'do
    it 'when table exists' do
      table_strategy_slug = 'grades'
      column_input_settings = {'student_group_id' => 1}
      table = create(
        :flexy_memory_table,
        table_strategy_slug: table_strategy_slug,
        column_input_settings: column_input_settings
      )
      existent_table = described_class.fetch_or_create(
        table_strategy_slug,
        column_input_settings
      )

      expect(existent_table).to eq(table)
    end

    it 'create new table' do
      table_strategy_slug = 'grades'
      column_input_settings = {'student_group_id' => 1}
      default_columns = [
        build(
          :flexy_memory_column,
          strategy_slug: 'student_subject_grade',
          strategy_inputs: {
            'student_group_id' => 1
          }
        )
      ]
      allow(FlexyTable).to receive(:default_columns_for_table).
        and_return(default_columns)
      table = described_class.fetch_or_create(
        table_strategy_slug,
        column_input_settings
      )

      expect(table.table_strategy_slug).to eq(table_strategy_slug)
      expect(table.column_input_settings).to eq(column_input_settings)
      expect(table.columns.count).to eq 1
      expect(table.columns.first.strategy_slug).to eq 'student_subject_grade'
    end
  end

  describe '#default_columns' do
    it do
      table_strategy_slug = 'grades'
      column_input_settings = {
        'student_group_id' => 1
      }
      default_columns = [
        {
          'strategy_slug' => 'student_subject_grade',
          'strategy_inputs' => {
            'student_group_id' => 1
          }
        }
      ]
      allow(FlexyTable).to receive(:default_columns_for_table).
        with(table_strategy_slug, column_input_settings).
        and_return(default_columns)
      table = described_class.new(
        table_strategy_slug: table_strategy_slug,
        column_input_settings: column_input_settings
      )
      columns = table.default_columns

      expect(columns.count).to eq 1
      expect(columns.first.strategy_slug).to eq('student_subject_grade')
      expect(columns.first.strategy_inputs).to eq(
        'student_group_id' => 1
      )
    end
  end
end
