import React from 'react';
import Typeahead from '../Typeahead/index.jsx';
import FlexyTable from '../FlexyTable/index.jsx';
import immutable from 'seamless-immutable';

class GradesTable extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      columnInputSettings: immutable({
        student_group_id: this.props.studentGroupId,
      }),
    };

    this.studentGroupId = {
      studentGroupId: this.props.studentGroupId,
    };

    this.updateStudentYear = this.updateStudentYear.bind(this);
    this.flexyTable = this.flexyTable.bind(this);
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
      const columnStrategyInputs = {
        student_group_id: this.props.studentGroupId,
      };

      return (
        <FlexyTable
          tableStrategySlug={this.props.tableStrategySlug}
          defaultColumns={this.props.defaultColumns}
          columnInputSettings={this.state.columnInputSettings}
          columnStrategyInputs={columnStrategyInputs}
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
        <div className="sidebar_section panel flexy-table-filter">
          <h3>Anul de studii</h3>
          <div className="panel_contents">
            <Typeahead
              strategyInputs={this.studentGroupId}
              strategySlug="semester_year"
              onChange={this.updateStudentYear}
            />
          </div>
        </div>

        {this.flexyTable()}
      </div>
    );
  }
}

GradesTable.propTypes = {
  tableStrategySlug: React.PropTypes.string.isRequired,
  defaultColumns: React.PropTypes.array,
  studentGroupId: React.PropTypes.number.isRequired,
};

GradesTable.defaultProps = {
  defaultColumns: [],
};

module.exports = GradesTable;
