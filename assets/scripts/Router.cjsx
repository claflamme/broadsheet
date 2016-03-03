React = require 'react'
{ render } = require 'react-dom'
{ Provider } = require 'react-redux'
configureStore = require './store/configureStore'
{ Router, Route, IndexRoute, browserHistory } = require 'react-router'

routes =

  <Provider store={ configureStore() }>
    <Router history={ browserHistory }>
      <Route path='/reader'>
        <IndexRoute component={ require './containers/Dashboard' } />
      </Route>
      <Route path='/login' component={ require './containers/Login' } />
      <Route path='/register' component={ require './containers/Register' } />
    </Router>
  </Provider>

if root = document.getElementById 'root'
  render routes, root