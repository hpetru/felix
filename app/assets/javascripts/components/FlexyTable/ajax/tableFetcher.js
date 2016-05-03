import React from 'react';
import $ from 'jquery';

function tableFetcher({ id, onSuccess }) {
  const httpMethod = 'GET';
  const apiEndpoint = `/api/v0/tables/${id}`;

  $.ajax({
    method: httpMethod,
    url: apiEndpoint,
    success: onSuccess,
    error: onSuccess,
    /*
    error: () => {
      console.log('API endpoit error');
    }
    */
  });
}

tableFetcher.propTypes = {
  id: React.PropTypes.number.isRequired,
  onSuccess: React.PropTypes.func.isRequired,
}

module.exports = tableFetcher;
