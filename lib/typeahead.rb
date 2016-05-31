module Typeahead
  STRATEGIES = [
    Typeahead::SubjectName
  ].freeze

  def self.new_strategy(strategy_slug, strategy_inputs)
    strategy_class = applicable_strategy(strategy_slug)
    strategy_class.new(strategy_inputs)
  end

  def self.applicable_strategy(strategy_slug)
    klass = STRATEGIES.detect do |strategy_class|
      strategy_class.strategy_slug == strategy_slug
    end

    unless klass
      raise NotImplementedError
    end

    klass
  end
end
