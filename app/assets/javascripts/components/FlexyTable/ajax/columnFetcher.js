import React from 'react';
import $ from 'jquery';

function columnFetcher({ columnStrategySlug, tableStrategySlug, onSuccess, strategyInputs }) {
  const method = 'GET';
  const url = '/api/v0/flexy_table';
  const data = {
    table_strategy_slug: tableStrategySlug,
    column_strategy_slug: columnStrategySlug,
    strategy_inputs: strategyInputs,
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

columnFetcher.propTypes = {
  strategyInputs: React.PropTypes.object.isRequired,
  onSuccess: React.PropTypes.func.isRequired,
  columnStrategySlug: React.PropTypes.string.isRequired,
  tableStrategySlug: React.PropTypes.string.isRequired,
};

module.exports = columnFetcher;
