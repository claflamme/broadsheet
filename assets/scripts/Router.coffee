React = require 'react'
el = React.createElement
{ Router, Route, IndexRoute, Redirect, browserHistory } = require 'react-router'

module.exports = ->
  el Router, history: browserHistory,
    el Redirect, from: '/', to: '/feeds/all'
    el Route, path: '/', component: require('./containers/Dashboard'),
      el Route, path: 'feeds/all', component: require('./containers/ArticlesAll')
      el Route, path: 'feeds/:feedId', component: require('./containers/ArticlesByFeed')
    el Route, path: '/callback', component: require('./containers/AuthCallback')
    el Route, path: '/authenticate', component: require('./containers/Auth')
    el Route, path: '/logout', component: require('./containers/Logout')
    el Route, path: '*', component: require('./containers/PageNotFound')
