React = require 'react'
{ render } = require 'react-dom'
{ Provider } = require 'react-redux'
configureStore = require './store/configureStore'
{ Router, Route, IndexRoute, browserHistory } = require 'react-router'

routes =

  <Provider store={ configureStore() }>
    <Router history={ browserHistory }>
      <Route path='/' component={ require './containers/Dashboard' }>
        <IndexRoute component={ require './containers/ArticlesAll' } />
        <Route path='subscriptions/:subscriptionId' component={ require './containers/ArticlesBySubscription' } />
      </Route>
      <Route path='/login' component={ require './containers/Login' } />
      <Route path='/register' component={ require './containers/Register' } />
      <Route path='*' component={ require './containers/404' } />
    </Router>
  </Provider>

if root = document.getElementById 'root'
  render routes, root
