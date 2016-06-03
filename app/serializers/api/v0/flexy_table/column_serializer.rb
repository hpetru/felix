class Api::V0::FlexyTable::ColumnSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :strategy_slug,
    :strategy_inputs,
    :cells,
    :schema
  )
end
