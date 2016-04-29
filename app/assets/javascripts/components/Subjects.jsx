import React from 'react';
import _ from 'lodash';
import { immutableRenderDecorator } from 'react-immutable-render-mixin';

class List extends React.Component {
  subjectComponents() {
    const subjectComponentList = [];

    _.each(this.props.subjects, (subject) => {
      subjectComponentList.push(
        <div>
          {subject.name}
        </div>
      )
    });

    return subjectComponentList;
  }

  render() {
    return (
      <div>
        {this.subjectComponents()}
      </div>
    )
  }
}

List.defaultProps = {
  subjects: []
}

module.exports = immutableRenderDecorator(List);
