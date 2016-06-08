module FlexyTable
  class Base
    include SchemaHashValidator

    def self.strategy_slug
      raise NotImplementedError
    end

    def self.strategy_inputs_schema
      raise NotImplementedError
    end

    attr_reader :strategy_inputs, :errors
    def initialize(strategy_inputs)
      @strategy_inputs = strategy_inputs
      @errors = ActiveModel::Errors.new(self)
    end

    def validate!
      schema = self.class.strategy_inputs_schema
      validate_hash_schema(
        schema,
        @strategy_inputs,
        errors
      )
    end

    def valid?
      validate!
      errors.empty?
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
        'column' => strategy_column,
        'strategy_slug' => self.class.strategy_slug,
        'strategy_inputs' => strategy_inputs
      }
    end
  end
end
