React = require 'react'
{ render } = require 'react-dom'
{ Provider } = require 'react-redux'
configureStore = require './store/configureStore'
{ Router, Route, IndexRoute, hashHistory } = require 'react-router'

module.exports =

  <Provider store={ configureStore() }>
    <Router history={ hashHistory }>
      <Route path='/'>
        <IndexRoute component={ require './containers/Dashboard' } />
      </Route>
    </Router>
  </Provider>
