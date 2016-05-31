module Typeahead
  class Base
    def self.strategy_slug
      raise NotImplementedError
    end

    def self.strategy_inputs_schema
      raise NotImplementedError
    end

    def initialize(strategy_inputs)
      @strategy_inputs = strategy_inputs
    end

    private

    def query
      @strategy_inputs['query']
    end
  end
end
