import React from 'react';
import Modal from 'react-modal';
import Form from './Form/index.jsx';

class FlexyModalForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      modalIsOpen: false,
    }

    this.openModal = this.openModal.bind(this);
    this.handleModalCloseRequest = this.handleModalCloseRequest.bind(this);
  }

  openModal() {
    this.setState({ modalIsOpen: true });
  }

  handleModalCloseRequest() {
    this.setState({ modalIsOpen: false });
  }

  componentWillMount() {
    Modal.setAppElement('body');
  }

  render() {
    return (
      <div>
        <button className="btn btn-primary" onClick={this.openModal}>Open Modal</button>
        <Modal
          isOpen={this.state.modalIsOpen}
          className="modal-dialog">
          <div className="modal-body">
            <Form
              strategySlug={this.props.strategySlug}
              />
          </div>
          <div className="modal-footer">
            <button type="button" className="btn btn-default" onClick={this.handleModalCloseRequest}>Close</button>
            <button type="button" className="btn btn-primary">Save</button>
        </div>
        </Modal>
      </div>
    )
  }
}

FlexyModalForm.propTypes = {
  strategySlug: React.PropTypes.string.isRequired,
}

module.exports = FlexyModalForm;
