import React from 'react';
<<<<<<< f0e62338756701fc4c2c1d2b7ca3db2f2ebd592f
<<<<<<< 3cc8e19920880cc8f630a961788b9e50a5986382
import Th from './Th.jsx';
=======
>>>>>>> table skeleton
=======
import Th from './Th.jsx';
>>>>>>> spike

class Thead extends React.Component {
  constructor(props) {
    super(props);
  }

  headerColumns() {
    let columns = [];

    for(const column of this.props.columns) {
      columns.push(
<<<<<<< f0e62338756701fc4c2c1d2b7ca3db2f2ebd592f
<<<<<<< 3cc8e19920880cc8f630a961788b9e50a5986382
=======
>>>>>>> spike
        <Th
          label={column.label}
          columnId={column.id}
        />
<<<<<<< f0e62338756701fc4c2c1d2b7ca3db2f2ebd592f
=======
        <th>
          Heheaa
        </th>
>>>>>>> table skeleton
=======
>>>>>>> spike
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
