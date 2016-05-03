module FlexyTable
  class Base
    def self.strategy_slug
      raise NotImplementedError
    end

    def self.strategy_inputs_schema
      raise NotImplementedError
    end

    attr_reader :strategy_inputs, :errors
    def initialize(strategy_inputs)
      @strategy_inputs = strategy_inputs
      @errors = []
    end

    # TODO: Write real validation method
    def valid?
      true
    end

    def strategy_data
      raise NotImplementedError
    end

    def strategy_column
      raise NotImplementedError
    end

    def data
      {
        'cells' => strategy_data,
        'column' => strategy_column
      }
    end
  end
end
