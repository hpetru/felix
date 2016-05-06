import React from 'react';
import Modal from 'react-modal';
import Form from './Form/index.jsx';

class FlexyModalForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      formVisible: false
    }
  }

  componentWillMount() {
    Modal.setAppElement('body');
  }

  toggleFormVisibility(formVisible) {
    this.setState({ formVisible });
  }

  render() {
    return (
      <Modal
        isOpen={this.state.formVisible}
        className="modal-dialog">
        <Form
          recordData={this.props.recordData}
          strategySlug={this.props.strategySlug}
          onSaveSuccess={this.props.onSaveSuccess}
          onToggleVisibility={this.toggleFormVisibility}
        />
      </Modal>
    )
  }
}

FlexyModalForm.propTypes = {
  strategySlug: React.PropTypes.string.isRequired,
  onSaveSuccess: React.PropTypes.func.isRequired,
  visible: React.PropTypes.bool.isRequired,
}

FlexyModalForm.defaultProps = {
  visible: false,
}

module.exports = FlexyModalForm;
