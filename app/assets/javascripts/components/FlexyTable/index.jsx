import React from 'react';
import _ from 'underscore';
<<<<<<< 3cc8e19920880cc8f630a961788b9e50a5986382
import Thead from './Thead.jsx';
import Tbody from './Tbody.jsx';
import tableFetcher from './ajax/tableFetcher.js';
import columnFetcher from './ajax/columnFetcher.js';
import immutable from 'seamless-immutable';
import { immutableRenderDecorator } from 'react-immutable-render-mixin';

class FlexyTable extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      columns: immutable([]),
      rows: immutable([]),
    };

    this.loadTable = this.loadTable.bind(this);
    this.addColumn = this.addColumn.bind(this);

    this.loadDefaultColumns();
  }

  componentDidMount() {
    // Va fi folosit in viitor ...
    // this.loadTable();
  }

  loadDefaultColumns() {
    for(const column of this.props.defaultColumns) {
      columnFetcher({
        tableStrategySlug: this.props.tableStrategySlug,
        columnStrategySlug: column.strategySlug,
        strategyInputs: column.strategyInputs,
        onSuccess: (response) => {
          this.addColumn(response);
        },
      })
    }
  }

  loadTable() {
    tableFetcher({
      id: 1,
      onSuccess: (response) => {
        const testColumns = [
          {
            id: '1',
            label: 'Nume',
            cells: [
              [1, 'Ion Brehna'],
              [2, 'Vasile Bogdan'],
              [3, 'Stefan Ionica'],
            ]
          },
          {
            id: '2',
            label: 'Medie',
            cells: [
              [1, 8.4],
              [2, 3.9],
              [3, 10],
            ]
          },
        ];

        for(const column of testColumns) {
          this.addColumn(column);
        }
      }
    });
  }


  addColumn(column_data) {
    const newColumns = this.state.columns.asMutable();
    const newRows = this.state.rows.asMutable({ deep: true });
    const rows = column_data.cells;
    const column = column_data.column;
    const columnSchema = {
      id: column.id,
      label: column.label
    };
    newColumns.push(columnSchema);

    for(const tuple of rows) {
      const id = tuple[0];
      const value = tuple[1];

      let applicableRow = _.findWhere(newRows, { id });
      if(applicableRow) {
        applicableRow[columnSchema.id] = value;
      }
      else {
        let newRow = { id };
        newRow[columnSchema.id] = value;
        newRows.push(newRow);
      }
    }

    this.setState(
      {
        rows: immutable(newRows),
        columns: immutable(newColumns)
      }
    )
  }

  render() {
    return (
      <div className="flexy-table">
        <table className="table table-striped">
          <Thead
            columns={this.state.columns}
          />
          <Tbody
            columns={this.state.columns}
            rows={this.state.rows}
          />
        </table>
      </div>
    );
  }
}

FlexyTable.propTypes = {
  tableStrategySlug: React.PropTypes.string.isRequired,
}

FlexyTable.defaultProps = {
  defaultColumns: []
}

module.exports = immutableRenderDecorator(FlexyTable);
