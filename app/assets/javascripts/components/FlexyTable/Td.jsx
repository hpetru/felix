import React from 'react';

class Td extends React.Component {
  constructor(props) {
    super(props);

    this.updateCell = this.updateCell.bind(this);
    this.leaveCell = this.leaveCell.bind(this);
  }

  updateCell(event) {
    const value = event.target.value;
    this.props.onUpdateCell(
      value,
      this.props.columnId,
      this.props.rowId
    );
  }

  leaveCell(event) {
    const value = event.target.value;
    this.props.onLeaveCell(
      value,
      this.props.columnId,
      this.props.rowId
    );
  }

  cellContent() {
    if (this.props.editable) {
      return (
        <input
          type="text"
          value={this.props.value}
          onChange={this.updateCell}
          onBlur={this.leaveCell}
        />
      );
    }

    return (
      <label>
        {this.props.value}
      </label>
    );
  }

  render() {
    return (
      <td>
        {this.cellContent()}
      </td>
    )
  }
}

Td.propTypes = {
  value: React.PropTypes.oneOfType([
    React.PropTypes.string,
    React.PropTypes.number,
  ]),
  rowId: React.PropTypes.oneOfType([
    React.PropTypes.string,
    React.PropTypes.number,
  ]).isRequired,
  columnId: React.PropTypes.oneOfType([
    React.PropTypes.string,
    React.PropTypes.number,
  ]),
  onUpdateCell: React.PropTypes.func.isRequired,
  onLeaveCell: React.PropTypes.func.isRequired,
  editable: React.PropTypes.bool.isRequired,
};

Td.defaultProps = {
  editable: false,
}

module.exports = Td;
