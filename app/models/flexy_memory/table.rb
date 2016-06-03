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

class FlexyMemory::Table < ActiveRecord::Base
  has_many(
    :columns,
    foreign_key: :flexy_memory_table_id
  )

  validates(
    :table_strategy_slug,
    presence: :true,
    inclusion: { in: FlexyTable.table_strategy_slugs }
  )

  def self.fetch_or_create(table_strategy_slug, column_input_settings)
    table = where(
      table_strategy_slug: table_strategy_slug,
      column_input_settings: column_input_settings.to_json
    ).first_or_initialize

    if table.new_record?
      table.columns = table.default_columns
      table.save!
    end

    table
  end

  def default_columns
    column_inputs = FlexyTable.default_columns_for_table(
      table_strategy_slug,
      column_input_settings
    )

    column_inputs.map do |column_input|
      FlexyMemory::Column.new(
        table: self,
        strategy_slug: column_input['strategy_slug'],
        strategy_inputs: column_input['strategy_inputs']
      )
    end
  end
end
