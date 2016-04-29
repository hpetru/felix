// Setup React in global scope

const React = window.React = require('react');
const ReactDOM = window.ReactDOM = require('react-dom');

const app = window.app = {
  MyTest: require('./components/MyTest.jsx'),
  Subjects: require('./components/Subjects.jsx'),
};
