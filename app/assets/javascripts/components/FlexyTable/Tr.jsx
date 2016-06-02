import React from 'react';
import Td from './Td.jsx';

class Tr extends React.Component {
  render() {
    const tdList = [];
    const rowData = this.props.rowData;

    for(const column of this.props.columns) {
      tdList.push(
        <Td
          rowId={rowData.id}
          columnId={column.id}
          key={column.id}
          value={rowData[column.id]}
          editable={column.editable}
          onUpdateCell={this.props.updateCell}
          onLeaveCell={this.props.leaveCell}
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
  updateCell: React.PropTypes.func.isRequired,
  leaveCell: React.PropTypes.func.isRequired,
}

module.exports = Tr;
