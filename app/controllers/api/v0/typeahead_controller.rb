module Api
  module V0
    class TypeaheadController < ApplicationController
      def index
        strategy = Typeahead.new_strategy(
          params[:strategy_slug],
          strategy_inputs
        )

        render(
          json: {
            results: strategy.strategy_data
          },
          status: :ok
        )
      end

      private

      def strategy_inputs
        JSON.parse(params[:strategy_inputs])
      end
    end
  end
end
