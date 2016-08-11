React = require 'react'
{ Router, Route, IndexRoute, browserHistory } = require 'react-router'

module.exports = ->

  <Router history={ browserHistory }>
    <Route path='/' component={ require './containers/Dashboard' }>
      <IndexRoute component={ require './containers/ArticlesAll' } />
      <Route path='feeds/:feedId' component={ require './containers/ArticlesByFeed' } />
      <Route path='settings' component={ require './containers/Settings' } />
    </Route>
    <Route path='/callback' component={ require './containers/AuthCallback' } />
    <Route path='/authenticate' component={ require './containers/Auth' } />
    <Route path='/logout' component={ require './containers/Logout' } />
    <Route path='*' component={ require './containers/404' } />
  </Router>
