import React from 'react';
import _ from 'underscore';
import Thead from './Thead.jsx';
import Tbody from './Tbody.jsx';
import ControlBar from './ControlBar/index.jsx';
import tableFetcher from './ajax/tableFetcher.js';
import cellSaver from './ajax/cellSaver.js';
import immutable from 'seamless-immutable';
import { immutableRenderDecorator } from 'react-immutable-render-mixin';

class FlexyTable extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      columns: immutable([]),
      rows: immutable([]),
    };

    this.addColumn = this.addColumn.bind(this);
    this.updateCell = this.updateCell.bind(this);
    this.saveCell = this.saveCell.bind(this);
    this.loadTable = this.loadTable.bind(this);
  }

  componentWillMount() {
    this.loadTable();
  }

  componentWillReceiveProps(nextProps) {
    this.props = nextProps;
    this.loadTable();
  }

  loadTable() {
    tableFetcher({
      tableStrategySlug: this.props.tableStrategySlug,
      columnInputSettings: this.props.columnInputSettings,
      onSuccess: (response) => {
        this.setState({
          tableId: response.id,
          columns: immutable([]),
          rows: immutable([]),
        });

        for(const column of response.columns) {
          this.addColumn(column);
        }
      }
    });
  }

  addColumn(column_data) {
    const newColumns = this.state.columns.asMutable();
    const newRows = this.state.rows.asMutable({ deep: true });
    const rows = column_data.cells;
    const columnStrategySlug = column_data.strategy_slug;
    const column = column_data.schema;
    const strategyInputs = column_data.strategy_inputs;

    const columnSchema = {
      id: column_data.id,
      label: column.label,
      editable: column.editable,
      strategySlug: columnStrategySlug,
      strategyInputs,
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

  updateCell(value, columnId, rowId) {
    const rows = this.state.rows.asMutable({ deep: true });
    const row = _.findWhere(rows, { id: rowId });
    row[columnId] = value;

    this.setState({
      rows: immutable(rows),
    });
  }

  saveCell(value, columnId, rowId) {
    const columnSchema = _.findWhere(
      this.state.columns,
      { id: columnId }
    );

    cellSaver({
      rowId,
      value,
      tableStrategySlug: this.props.tableStrategySlug,
      columnStrategySlug: columnSchema.strategySlug,
      columnStrategyInputs: columnSchema.strategyInputs,
      onSuccess: () => {
        // TODO: Notify user
        console.log('Yay');
      },
    });
  }

  render() {
    return (
      <div className="flexy-table-wrapper">
        <div className="flexy-table">
          <ControlBar
            addColumnCallback={this.addColumn}
            tableId={this.state.tableId}
            tableStrategySlug={this.props.tableStrategySlug}
            columnInputSettings={this.props.columnInputSettings}
            columnStrategyInputs={this.props.columnStrategyInputs}
          />
          <div className="sidebar_section panel flexy-table-table-panel">
            <div className="panel_contents">
              <table className="table index_table flexy-table">
                <Thead
                  columns={this.state.columns}
                />
                <Tbody
                  columns={this.state.columns}
                  rows={this.state.rows}
                  updateCell={this.updateCell}
                  leaveCell={this.saveCell}
                />
              </table>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

FlexyTable.propTypes = {
  tableStrategySlug: React.PropTypes.string.isRequired,
  columnStrategyInputs: React.PropTypes.object.isRequired,
  columnInputSettings: React.PropTypes.object,
};

FlexyTable.defaultProps = {
  defaultColumns: [],
  columnInputSettings: {},
  columnStrategyInputs: {},
};

module.exports = immutableRenderDecorator(FlexyTable);
