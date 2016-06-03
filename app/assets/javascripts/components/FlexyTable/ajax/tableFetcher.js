import React from 'react';
import $ from 'jquery';

function tableFetcher({ tableStrategySlug, columnInputSettings, onSuccess }) {
  const method = 'POST';
  const url = `/api/v0/flexy_table/tables`;
  const data = {
    table: {
      table_strategy_slug: tableStrategySlug,
      column_input_settings: JSON.stringify(columnInputSettings),
    }
  };

  $.ajax({
    method,
    url,
    data,
    success: onSuccess,
  });
}

tableFetcher.propTypes = {
  tableStrategySlug: React.PropTypes.string.isRequired,
  columnInputSettings: React.PropTypes.object.isRequired,
  onSuccess: React.PropTypes.func.isRequired,
};

tableFetcher.defaultProps = {
  columnInputSettings: {},
};

module.exports = tableFetcher;
