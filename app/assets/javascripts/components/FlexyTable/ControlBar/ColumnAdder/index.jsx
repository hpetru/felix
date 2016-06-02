import React from 'react';
import Select from 'react-select';
import ColumnInput from '../ColumnInput/index.jsx';
import columnInputOptions from './columnInputOptions.jsx';
import immutable from 'seamless-immutable';
import columnFetcher from '../../ajax/columnFetcher.js';

class ColumnAdder extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      strategyInputs: immutable({}),
    };
    this.addColumn = this.addColumn.bind(this);
    this.columnStrategyInputType = this.columnStrategyInputType.bind(this);
    this.updateColumnStrategy = this.updateColumnStrategy.bind(this);
    this.updateColumnStrategyInputs = this.updateColumnStrategyInputs.bind(this);
  }

  addColumn(event) {
    event.preventDefault();
    const strategyInputs = Object.assign(
      this.props.columnStrategyInputs,
      this.state.strategyInputs
    );
    columnFetcher({
      columnStrategySlug: this.columnStrategySlug(),
      tableStrategySlug: this.props.tableStrategySlug,
      strategyInputs,
      onSuccess: (response) => {
        this.props.addColumnCallback(response);
        this.setState({
          columnStrategySlug: null,
          columnStrategy: null,
        });
      },
    });
  }

  updateColumnStrategy(columnStrategy) {
    this.setState({
      columnStrategy: columnStrategy,
    });
  }

  columnStrategyInputType() {
    if (this.state.columnStrategy) {
      return this.state.columnStrategy.value;
    }
    return null;
  }

  columnStrategySlug() {
    if (this.state.columnStrategy) {
      return this.state.columnStrategy.slug;
    }

    return null;
  }

  updateColumnStrategyInputs(strategyInputs) {
    this.setState({ strategyInputs });
  }

  render() {
    return (
      <div className="sidebar_section panel flexy-table-filter">
        <h3>Adaugă coloană</h3>
        <div className="panel_contents">
          <form onSubmit={this.addColumn} className="filter_form">
            <div className="filter_form_field">
              <Select
                clearable
                searchable
                value={this.state.columnStrategy}
                options={columnInputOptions[this.props.tableStrategySlug]}
                onChange={this.updateColumnStrategy}
              />
            </div>

            <ColumnInput
              inputType={this.columnStrategyInputType()}
              onUpdateStrategyInputs={this.updateColumnStrategyInputs}
              settings={this.props.columnInputSettings}
            />
            <div className="buttons">
              <input
                type="submit"
                value="Adagă"
              />
            </div>
          </form>
        </div>
      </div>
    )
  }
}

ColumnAdder.propTypes = {
  addColumnCallback: React.PropTypes.func.isRequired,
  tableStrategySlug: React.PropTypes.string.isRequired,
  columnInputSettings: React.PropTypes.object.isRequired,
  columnStrategyInputs: React.PropTypes.object.isRequired,
}

module.exports = ColumnAdder;
