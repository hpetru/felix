module Api
  module V0
    module FlexyTable
      class CellsController < ApplicationController
        def save
          strategy = FlexyTablePersistence.build_strategy(
            params[:table_strategy_slug],
            params[:column_strategy_slug],
            strategy_inputs
          )

          strategy.save
          render json: {}, status: :ok
        end

        private

        def strategy_inputs
          JSON.parse(params[:strategy_inputs])
        end
      end
    end
  end
end
