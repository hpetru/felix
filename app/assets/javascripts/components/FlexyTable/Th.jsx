import React from 'react';

class Th extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <th>
        {this.props.label}
      </th>
    )
  }
}

Th.propTypes = {
  label: React.PropTypes.string.isRequired,
  columnId: React.PropTypes.string.isRequired,
  permanent: React.PropTypes.bool.isRequired,
}

Th.defaultProps = {
  permanent: false
}

module.exports = Th;
