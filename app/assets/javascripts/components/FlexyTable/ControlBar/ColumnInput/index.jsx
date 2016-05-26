import React from 'react';
import componensMapping from './mapping.js';
import _ from 'underscore';

function ColumnInput({ inputType, onUpdateStrategyInputs, settings }) {
  const Component = componensMapping[inputType];

  if(_.isEmpty(inputType)) {
    return (
      <div />
    );
  }

  return (
    <Component
      onUpdateStrategyInputs={onUpdateStrategyInputs}
      settings={settings}
    />
  );
}

ColumnInput.propTypes = {
  inputType: React.PropTypes.string,
  onUpdateStrategyInputs: React.PropTypes.func.isRequired,
  settings: React.PropTypes.object.isRequired,
};

module.exports = ColumnInput;
