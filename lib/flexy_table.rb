module FlexyTable
  TABLE_STRATEGIES = [
    FlexyTable::StudentGroups,
    FlexyTable::Grades
  ].freeze

  def self.build_strategy(table_strategy_slug, column_strategy_slug, strategy_inputs)
    StrategyBuilder.new(
      table_strategy_slug,
      column_strategy_slug,
      strategy_inputs
    ).build
  end

  def self.default_columns_for_table(table_strategy_slug, column_input_settings)
    detect_table_strategy(table_strategy_slug).
      default_columns(column_input_settings)
  end

  def self.table_strategy_slugs
    TABLE_STRATEGIES.map(&:table_strategy_slug)
  end

  def self.column_strategy_slugs
    TABLE_STRATEGIES.flat_map do |table_strategy|
      table_strategy::STRATEGIES.map(&:strategy_slug)
    end
  end

  def self.detect_table_strategy(table_strategy_slug)
    TABLE_STRATEGIES.detect do |table_strategy|
      table_strategy.table_strategy_slug == table_strategy_slug
    end
  end
end
