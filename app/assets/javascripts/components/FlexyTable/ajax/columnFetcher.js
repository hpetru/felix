import React from 'react';
import $ from 'jquery';

function columnFetcher({ columnStrategySlug, tableStrategySlug, onSuccess, strategyInputs }) {
<<<<<<< 143c1f877298ca576401848e67eda6940873046b
  const method = 'GET';
  const url = `/api/v0/flexy_table`;
=======
  const httpMethod = 'GET';
  const apiEndpoint = `/api/v0/flexy_table`;
>>>>>>> load default strategies
  const data = {
    table_strategy_slug: tableStrategySlug,
    column_strategy_slug: columnStrategySlug,
    strategy_inputs: strategyInputs,
  };


  $.ajax({
<<<<<<< 143c1f877298ca576401848e67eda6940873046b
    url,
    method,
    data,
    success: onSuccess,
    error: () => {
      console.log('Failed to load data');
=======
    url: apiEndpoint,
    method: httpMethod,
    data: data,
    success: onSuccess,
    error: () => {
      console.logger('Failed to load data');
>>>>>>> load default strategies
    }
  });
}

<<<<<<< 143c1f877298ca576401848e67eda6940873046b
columnFetcher.propTypes = {
  strategyInputs: React.PropTypes.object.isRequired,
  onSuccess: React.PropTypes.func.isRequired,
  columnStrategySlug: React.PropTypes.string.isRequired,
  tableStrategySlug: React.PropTypes.string.isRequired,
};

=======
>>>>>>> load default strategies
module.exports = columnFetcher;
