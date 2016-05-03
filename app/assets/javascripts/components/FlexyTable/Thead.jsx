import React from 'react';
<<<<<<< 3cc8e19920880cc8f630a961788b9e50a5986382
import Th from './Th.jsx';
=======
>>>>>>> table skeleton

class Thead extends React.Component {
  constructor(props) {
    super(props);
  }

  headerColumns() {
    let columns = [];

    for(const column of this.props.columns) {
      columns.push(
<<<<<<< 3cc8e19920880cc8f630a961788b9e50a5986382
        <Th
          label={column.label}
          columnId={column.id}
        />
=======
        <th>
          Heheaa
        </th>
>>>>>>> table skeleton
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
