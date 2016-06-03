module Api
  module V0
    module FlexyTable
      class ColumnsController < ApplicationController
        def create
          column = FlexyMemory::Column.create(column_params)
          render(
            json: column,
            serializer: Api::V0::FlexyTable::ColumnSerializer
          )
        end

        private

        def column_params
          params.require(:column).
            permit(:strategy_slug, :strategy_inputs).
            merge(flexy_memory_table_id: params[:table_id])
        end
      end
    end
  end
end
