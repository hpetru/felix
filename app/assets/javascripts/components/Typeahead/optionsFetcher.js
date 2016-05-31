import React from 'react';
import $ from 'jquery';

function optionsFetcher({ onSuccess, strategySlug, strategyInputs, inputValue }) {
  const method = 'GET';
  const url = '/api/v0/typeahead';
  const requiredInputs = Object.assign(
    {
      page: 1,
      query: inputValue,
    },
    strategyInputs
  );
  const data = {
    strategy_slug: strategySlug,
    strategy_inputs: JSON.stringify(requiredInputs),
  };

  $.ajax({
    method,
    url,
    data,
    success: onSuccess,
  });
}

optionsFetcher.PropTypes = {
  strategySlug: React.PropTypes.string.isRequired,
  onSuccess: React.PropTypes.func.isRequired,
  strategyInputs: React.PropTypes.object,
  inputValue: React.PropTypes.string.isRequired,
};

optionsFetcher.defaultProps = {
  strategyInputs: {},
};

module.exports = optionsFetcher;
