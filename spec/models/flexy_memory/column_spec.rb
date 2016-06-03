# == Schema Information
#
# Table name: flexy_memory_columns
#
#  id                    :integer          not null, primary key
#  flexy_memory_table_id :integer          not null
#  strategy_inputs       :jsonb            default("{}"), not null
#  strategy_slug         :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'rails_helper'

describe FlexyMemory::Column do
  it { should validate_presence_of :table }
  it { should validate_presence_of :strategy_slug }
  it do
    should validate_inclusion_of(:strategy_slug).
      in_array(FlexyTable.column_strategy_slugs)
  end

  describe '#cells' do
    it do
      strategy_data_stub = double
      column_strategy_stub = double(
        :column_strategy_stub,
        strategy_data: strategy_data_stub
      )
      column = create(:flexy_memory_column)
      allow(column).to receive(:column_strategy).
        and_return(column_strategy_stub)

      expect(column.cells).to eq(
        strategy_data_stub
      )
    end
  end
end
