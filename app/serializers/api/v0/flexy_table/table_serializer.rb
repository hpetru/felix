class Api::V0::FlexyTable::TableSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :table_strategy_slug,
    :column_input_settings,
    :columns
  )

  def columns
    ActiveModel::Serializer::CollectionSerializer.new(
      object.columns,
      serializer: Api::V0::FlexyTable::ColumnSerializer
    )
  end
end
