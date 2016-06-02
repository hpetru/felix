class Api::V0::FlexyTableController < ApplicationController
  def index
    strategy = ::FlexyTable.build_strategy(
      params[:table_strategy_slug],
      params[:column_strategy_slug],
      params[:strategy_inputs]
    )

    if strategy.valid?
      render json: strategy.data, status: :ok
    else
      render json: strategy.errors, status: :unprocessable_entity
    end
  end
end
