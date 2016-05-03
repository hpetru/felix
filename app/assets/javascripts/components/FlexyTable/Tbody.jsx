import React from 'react';
<<<<<<< 3cc8e19920880cc8f630a961788b9e50a5986382
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
=======

class Tbody extends React.Component {
  render() {
    return (
      <tbody>
>>>>>>> table skeleton
      </tbody>
    )
  }
}

<<<<<<< 3cc8e19920880cc8f630a961788b9e50a5986382
Tbody.propTypes = {
  columns: React.PropTypes.array.isRequired,
  rows: React.PropTypes.array.isRequired,
}

=======
>>>>>>> table skeleton
module.exports = Tbody;
