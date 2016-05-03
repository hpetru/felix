module FlexyTable
  class StrategyBuilder
    def initialize(table_strategy_slug, column_strategy_slug, strategy_inputs)
      @table_strategy_slug = table_strategy_slug
      @column_strategy_slug = column_strategy_slug
      @strategy_inputs = strategy_inputs
    end

    def build
      applicable_strategy.new(
        @strategy_inputs
      )
    end

    private

    def applicable_table_strategy
      klass = strategies.detect do |strategy_class|
        strategy_class.table_strategy_slug == @table_strategy_slug
      end
      check_class!(klass)
    end

    def applicable_strategy
      klass = applicable_table_strategy::STRATEGIES.detect do |strategy_class|
        strategy_class.strategy_slug == @column_strategy_slug
      end
      check_class!(klass)
    end

    def strategies
      FlexyTable::TABLE_STRATEGIES
    end

    def check_class!(klass)
      if klass
        klass
      else
        raise NotImplementedError
      end
    end
  end
end
