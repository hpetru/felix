import React from 'react';
import Td from './Td.jsx';

class Tr extends React.Component {
  render() {
    const tdList = [];
    const rowData = this.props.rowData;

    for(const column of this.props.columns) {
      tdList.push(
        <Td
          key={column.id}
          value={rowData[column.id]}
        />
      )
    }

    return (
      <tr>
        {tdList}
      </tr>
    )
  }
}

Tr.propTypes = {
  columns: React.PropTypes.array.isRequired,
  rowData: React.PropTypes.object.isRequired,
}

module.exports = Tr;
