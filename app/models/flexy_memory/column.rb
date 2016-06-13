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

class FlexyMemory::Column < ActiveRecord::Base
  def self.fetch_or_create(column_params)
    column = where(column_params).first_or_initialize
    if column.new_record?
      column.save!
    end
    column
  end

  belongs_to(
    :table,
    foreign_key: :flexy_memory_table_id
  )

  validates(
    :table,
    :strategy_slug,
    presence: true
  )

  validates(
    :strategy_slug,
    inclusion: { in: FlexyTable.column_strategy_slugs }
  )

  def cells
    column_strategy.strategy_data
  end

  def schema
    column_strategy.strategy_column
  end

  private

  def column_strategy
    ::FlexyTable.build_strategy(
      table.table_strategy_slug,
      strategy_slug,
      strategy_inputs
    )
  end
end
