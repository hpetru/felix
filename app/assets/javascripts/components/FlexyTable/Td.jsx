import React from 'react';

class Td extends React.Component {
  render() {
    return (
      <td className="col">
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
