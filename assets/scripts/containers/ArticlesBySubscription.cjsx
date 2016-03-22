React = require 'react'
{ Navbar } = require 'react-bootstrap'
{ connect } = require 'react-redux'
ArticleActions = require '../actions/ArticleActions'
ArticleList = require '../components/ArticleList.cjsx'

mapStateToProps = (state) ->

  articles: state.articles
  subscriptions: state.subscriptions

module.exports = connect(mapStateToProps) React.createClass

  componentWillMount: ->

    @_reload @props.params.subscriptionId

  componentWillReceiveProps: (nextProps) ->

    if nextProps.params.subscriptionId isnt @props.params.subscriptionId
      @_reload nextProps.params.subscriptionId

  render: ->

    <ArticleList
      articles={ @props.articles }
      subscriptions={ @props.subscriptions } />

  _reload: (subscriptionId) ->

    @props.dispatch ArticleActions.fetchBySubscription subscriptionId
