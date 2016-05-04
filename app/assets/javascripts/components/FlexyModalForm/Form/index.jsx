import React from 'react';
import componentMapping from './componentMapping.js';

function Form({ strategySlug }) {
  const FormComponent = componentMapping[strategySlug];

  if(FormComponent === undefined) {
    console.warn(`Invalid strategySlug "${strategySlug}" specified`);
    return <div />;
  }

  return (
    <FormComponent />
  );

   //return (
   //  <div>
   //    <div className="form-group">
   //      <label className="control-label">Title</label>
   //      <input
   //        type="text"
   //        className="form-control"
   //      />
   //    </div>
   //    <div className="form-group">
   //      <label className="control-label">Content</label>
   //      <textarea
   //        className="form-control"
   //      />
   //    </div>
   //  </div>
   //);
}

Form.propTypes = {
  strategySlug: React.PropTypes.string.isRequired,
}

module.exports = Form;
