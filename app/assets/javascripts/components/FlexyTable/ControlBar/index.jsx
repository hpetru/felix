import React from 'react';
import ColumnAdder from './ColumnAdder/index.jsx';

class ControlBar extends React.Component {
  render() {
    return (
      <ColumnAdder
        addColumnCallback={this.props.addColumnCallback}
        tableStrategySlug={this.props.tableStrategySlug}
        columnInputSettings={this.props.columnInputSettings}
        columnStrategyInputs={this.props.columnStrategyInputs}
      />
    );
  }
}

ControlBar.propTypes = {
  addColumnCallback: React.PropTypes.func.isRequired,
  tableStrategySlug: React.PropTypes.string.isRequired,
  columnInputSettings: React.PropTypes.object.isRequired,
  columnStrategyInputs: React.PropTypes.object.isRequired,
};

module.exports = ControlBar;
