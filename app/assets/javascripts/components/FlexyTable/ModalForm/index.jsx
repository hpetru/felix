import React from 'react';
import Modal from 'react-modal';

class ModalForm extends React.Component {
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
          <div className="modal-header">
            <h2 className="modal-title text-center">Clase</h2>
          </div>
          <div className="modal-body">
            <div className="form-group">
              <label className="control-label">Title</label>
              <input
                type="text"
                className="form-control"
              />
            </div>
            <div className="form-group">
              <label className="control-label">Content</label>
              <textarea
                className="form-control"
              />
            </div>
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

module.exports = ModalForm;
