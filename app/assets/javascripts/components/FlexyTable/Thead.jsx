import React from 'react';
import Th from './Th.jsx';

class Thead extends React.Component {
  constructor(props) {
    super(props);
  }

  headerColumns() {
    let columns = [];

    for(const column of this.props.columns) {
      columns.push(
        <Th
          label={column.label}
          columnId={column.id}
        />
      );
    }

    return columns;
  }

  render() {
    return (
      <thead>
        <tr>
          {this.headerColumns()}
        </tr>
      </thead>
    )
  }
}

Thead.propTypes = {
  columns: React.PropTypes.array.isRequired
}

module.exports = Thead;
