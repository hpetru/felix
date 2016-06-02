module FlexyTablePersistence
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
    end

    # TODO: Implement validation ASAP

    def save
      raise NotImplementedError
    end
  end
end
