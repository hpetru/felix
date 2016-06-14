import React from 'react';
import Select from 'react-select';
import optionsFetcher from './optionsFetcher.js';

const ASYNC_DELAY = 500;

class Typeahead extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
    this.updateSelect = this.updateSelect.bind(this);
    this.getOptions = this.getOptions.bind(this);
  }

  getOptions(inputValue, callback) {
    optionsFetcher({
      inputValue,
      strategySlug: this.props.strategySlug,
      strategyInputs: this.props.strategyInputs,
      onSuccess: (response) => {
        setTimeout(() => {
          callback(
            null,
            {
              options: response.results,
            }
          )
        }, ASYNC_DELAY);
      }
    })
  }

  updateSelect(value) {
    if (this.props.onChange) {
      this.props.onChange(value);
    }

    this.setState({ value });
  }

  render() {
    return (
      <Select.Async
        name={this.props.name}
        value={this.state.value}
        onChange={this.updateSelect}
        loadOptions={this.getOptions}
      />
    );
  }
}

Typeahead.propTypes = {
  strategySlug: React.PropTypes.string.isRequired,
  strategyInputs: React.PropTypes.object,
  name: React.PropTypes.string.isRequired,
  onChange: React.PropTypes.func,
};

Typeahead.defaultProps = {
  strategyInputs: {},
};

module.exports = Typeahead;
