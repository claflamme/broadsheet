React = require 'react'
{ Router, Route, IndexRoute, browserHistory } = require 'react-router'

module.exports = ->

  <Router history={ browserHistory }>
    <Route path='/' component={ require './containers/Dashboard' }>
      <IndexRoute component={ require './containers/ArticlesAll' } />
      <Route path='feeds/:feedId' component={ require './containers/ArticlesByFeed' } />
    </Route>
    <Route path='/login' component={ require './containers/Login' } />
    <Route path='/logout' component={ require './containers/Logout' } />
    <Route path='/register' component={ require './containers/Register' } />
    <Route path='*' component={ require './containers/404' } />
  </Router>
