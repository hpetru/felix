import React from 'react';
import componentMapping from './componentMapping.js';

function Form({ strategySlug, onToggleVisibility, onSaveSuccess }) {
  const FormComponent = componentMapping[strategySlug];

  if(FormComponent === undefined) {
    console.warn(`Invalid strategySlug "${strategySlug}" specified`);
    return <div />;
  }

  return (
    <FormComponent
      onSaveSuccess={onSaveSuccess}
      onToggleVisibility={onToggleVisibility}
    />
  );
}

Form.propTypes = {
  strategySlug: React.PropTypes.string.isRequired,
  onSaveSuccess: React.PropTypes.func.isRequired,
  onToggleVisibility: React.PropTypes.func.isRequired,
}

module.exports = Form;
