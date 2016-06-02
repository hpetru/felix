import React from 'react';
import $ from 'jquery';

function cellSaver({ rowId, value, tableStrategySlug, columnStrategySlug, columnStrategyInputs, onSuccess }) {
  const method = 'POST';
  const url = '/api/v0/flexy_table/cells';
  const strategyInputs = Object.assign(
    {
      value,
      row_id: rowId,
    },
    columnStrategyInputs
  );
  const data = {
    value,
    table_strategy_slug: tableStrategySlug,
    column_strategy_slug: columnStrategySlug,
    strategy_inputs: JSON.stringify(strategyInputs),
  };

  $.ajax({
    method,
    url,
    data,
    success: onSuccess,
    error: () => {
      // TODO: Notify user
      console.log('Fail to save cell data', data);
    },
  });
}

cellSaver.propTypes = {
  rowId: React.PropTypes.oneOfType([
    React.PropTypes.string,
    React.PropTypes.number,
  ]),
  value: React.PropTypes.string.isRequired,
  tableStrategySlug: React.PropTypes.string.isRequired,
  columnStrategySlug: React.PropTypes.string.isRequired,
  onSuccess: React.PropTypes.func.isRequired,
  columnStrategyInputs: React.PropTypes.object.isRequired,
};

cellSaver.defaultProps = {
  columnStrategyInputs: {},
};

module.exports = cellSaver;
