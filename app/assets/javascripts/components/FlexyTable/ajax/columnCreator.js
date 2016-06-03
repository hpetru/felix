import React from 'react';
import $ from 'jquery';

function columnCreator({ tableId, columnStrategySlug, tableStrategySlug, onSuccess, strategyInputs }) {
  const method = 'POST';
  const url = `/api/v0/flexy_table/tables/${tableId}/columns`;
  const data = {
    column: {
      strategy_slug: columnStrategySlug,
      strategy_inputs: JSON.stringify(
        strategyInputs
      ),
    },
  };

  $.ajax({
    url,
    method,
    data,
    success: onSuccess,
    error: () => {
      console.log('Failed to load data');
    }
  });
}

columnCreator.propTypes = {
  strategyInputs: React.PropTypes.object.isRequired,
  onSuccess: React.PropTypes.func.isRequired,
  columnStrategySlug: React.PropTypes.string.isRequired,
  tableStrategySlug: React.PropTypes.string.isRequired,
  tableId: React.PropTypes.number.isRequired,
};

module.exports = columnCreator;
