import React from 'react';

class Td extends React.Component {
  render() {
    return (
      <td>
        {this.props.value}
      </td>
    )
  }
}

Td.propTypes = {
  value: React.PropTypes.oneOfType([
    React.PropTypes.string,
    React.PropTypes.number,
  ]),
}

module.exports = Td;
