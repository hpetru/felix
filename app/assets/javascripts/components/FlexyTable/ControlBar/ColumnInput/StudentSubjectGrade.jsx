import React from 'react';
import immutable from 'seamless-immutable';
import Typeahead from '../../../Typeahead/index.jsx';

class StudentSubjectGrade extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      isThesis: false,
      strategyInputs: immutable({
        grade_type: 'semester',
      }),
    };

    this.updateThesis = this.updateThesis.bind(this);
    this.updateSubject = this.updateSubject.bind(this);
    this.updateSemester = this.updateSemester.bind(this);
  }

  updateStrategyInputs() {
    this.props.onUpdateStrategyInputs(
      this.state.strategyInputs
    );
  }

  updateThesis() {
    this.setState({ isThesis: !this.state.isThesis }, () => {
      const strategyInputs = this.state.strategyInputs.set(
        'grade_type',
        this.gradeTypeValue()
      );

      this.setState(
        { strategyInputs },
        this.updateStrategyInputs
      );
    });
  }

  updateSubject(subject) {
    this.setState({ subject }, () => {
      const strategyInputs = this.state.strategyInputs.set(
        'subject_id',
        this.subjectValue()
      );

      this.setState(
        { strategyInputs },
        this.updateStrategyInputs
      );
    });
  }

  updateSemester(semester) {
    this.setState({ semester }, () => {
      const strategyInputs = this.state.strategyInputs.set(
        'semester_id',
        this.semesterValue()
      );

      this.setState(
        { strategyInputs },
        this.updateStrategyInputs
      );
    });
  }

  subjectValue() {
    const subject = this.state.subject;
    if (!subject) {
      return '';
    }

    return subject.value;
  }

  semesterValue() {
    const semester = this.state.semester;
    if (!semester) {
      return '';
    }

    return semester.value;
  }

  gradeTypeValue() {
    if (this.state.isThesis) {
      return 'thesis';
    }

    return 'semester';
  }

  render() {
    return (
      <div>
        <Typeahead
          placeholder="Alege materia"
          name="subject_name"
          strategySlug="subject_name"
          onChange={this.updateSubject}
        />
        <Typeahead
          placeholder="Alege semestrul"
          name="semester_name"
          strategySlug="semester_name"
          strategyInputs={{ year: this.props.settings.year }}
          onChange={this.updateSemester}
        />

        <hr />

        <label>
          <input
            type="checkbox"
            name="thesis"
            checked={this.state.isThesis}
            onChange={this.updateThesis}
          />
          Teză
        </label>
      </div>
    );
  }
}

StudentSubjectGrade.propTypes = {
  onUpdateStrategyInputs: React.PropTypes.func.isRequired,
  settings: React.PropTypes.shape({
    year: React.PropTypes.number.isRequired,
  }),
};

module.exports = StudentSubjectGrade;
