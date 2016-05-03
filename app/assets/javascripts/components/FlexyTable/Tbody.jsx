import React from 'react';
import Tr from './Tr.jsx';

class Tbody extends React.Component {
  render() {
    const trList = [];
    let i = 0;

    for(const row of this.props.rows) {
      trList.push(
        <Tr
          key={i}
          columns={this.props.columns}
          rowData={row}
        />
      )
      i += 1;
    }

    return (
      <tbody>
        {trList}

class Tbody extends React.Component {
  render() {
    return (
      <tbody>
      </tbody>
    )
  }
}


Tbody.propTypes = {
  columns: React.PropTypes.array.isRequired,
  rows: React.PropTypes.array.isRequired,
}

module.exports = Tbody;
