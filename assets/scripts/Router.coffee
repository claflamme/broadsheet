React = require 'react'
c = React.createElement
{ Router, Route, IndexRoute, browserHistory } = require 'react-router'

module.exports = ->

  c Router, { history: browserHistory },
    c Route, { path: '/', component: require './containers/Dashboard' },
      c IndexRoute, { component: require './containers/ArticlesAll' }
      c Route, { path: 'feeds/:feedId', component: require './containers/ArticlesByFeed' }
    c Route, { path: '/callback', component: require './containers/AuthCallback' }
    c Route, { path: '/authenticate', component: require './containers/Auth' }
    c Route, { path: '/logout', component: require './containers/Logout' }
    c Route, { path: '*', component: require './containers/404' }
