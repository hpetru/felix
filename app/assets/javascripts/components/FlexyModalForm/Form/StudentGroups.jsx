import React from 'react';

class StudentGroups extends React.Component {
  render() {
    return (
      <div>
        <div className="form-group">
          <label className="control-label">Title</label>
          <input
            type="text"
            className="form-control"
          />
        </div>
        <div className="form-group">
          <label className="control-label">Content</label>
          <textarea
            className="form-control"
          />
        </div>
      </div>
    )
  }
};

StudentGroups.propTypes = {
  onSaveSuccess: React.PropTypes.func.isRequired,
  onToggleVisibility: React.PropTypes.func.isRequired,
}

module.exports = StudentGroups;
