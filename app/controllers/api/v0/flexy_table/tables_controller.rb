module Api
  module V0
    module FlexyTable
      class TablesController < ApplicationController
        def create
          table = FlexyMemory::Table.fetch_or_create(
            table_params[:table_strategy_slug],
            table_params[:column_input_settings]
          )

          render(
            json: table,
            serializer: Api::V0::FlexyTable::TableSerializer
          )
        end

        private

        def table_params
          params.require(:table).
            permit(:table_strategy_slug).
            tap do |params_hash|
              params_hash[:column_input_settings] = JSON.parse(
                params[:table][:column_input_settings]
              )
            end
        end
      end
    end
  end
end
