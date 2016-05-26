import React from 'react';
import Typeahead from '../Typeahead/index.jsx';
import FlexyTable from '../FlexyTable/index.jsx';
import immutable from 'seamless-immutable';

class GradesTable extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      columnInputSettings: immutable({ }),
    };

    this.updateStudentYear = this.updateStudentYear.bind(this);
  }

  updateStudentYear(year) {
    const columnInputSettings = this.state.columnInputSettings.set(
      'year',
      year.value
    );
    this.setState({ columnInputSettings });
  }

  flexyTable() {
    if (this.state.columnInputSettings.year) {
      return (
        <FlexyTable
          tableStrategySlug={this.props.tableStrategySlug}
          defaultColumns={this.props.defaultColumns}
          columnInputSettings={this.state.columnInputSettings}
        />
      );
    }

    return (
      <div />
    )
  }

  render() {
    return (
      <div>
        <Typeahead
          strategySlug="semester_year"
          onChange={this.updateStudentYear}
        />

        {this.flexyTable()}
      </div>
    );
  }
}

GradesTable.propTypes = {
  tableStrategySlug: React.PropTypes.string.isRequired,
  defaultColumns: React.PropTypes.array,
};

GradesTable.defaultProps = {
  defaultColumns: [],
};

module.exports = GradesTable;
