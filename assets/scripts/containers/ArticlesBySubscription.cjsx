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
      loadMore={ @_loadMore }
      articles={ @props.articles }
      onClick={ @_onClick } />

  _reload: (subscriptionId) ->

    @props.dispatch ArticleActions.fetchBySubscription subscriptionId

  _loadMore: ->

    nextPage = @props.articles.page + 1
    subscriptionId = @props.params.subscriptionId

    @props.dispatch ArticleActions.fetchBySubscription subscriptionId, nextPage

  _onClick: (article) ->

    @props.dispatch ArticleActions.fetchContent article
