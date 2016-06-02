module FlexyTablePersistence
  TABLE_STRATEGIES = [
    FlexyTablePersistence::Grades
  ].freeze

  def self.build_strategy(table_strategy_slug, column_strategy_slug, strategy_inputs)
    StrategyBuilder.new(
      table_strategy_slug,
      column_strategy_slug,
      strategy_inputs
    ).build
  end
end
