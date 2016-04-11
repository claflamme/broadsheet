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

    @_reload @props.params.feedId

  componentWillReceiveProps: (nextProps) ->

    if nextProps.params.feedId isnt @props.params.feedId
      @_reload nextProps.params.feedId

  render: ->

    <ArticleList
      loadMore={ @_loadMore }
      articles={ @props.articles }
      onClick={ @_onClick } />

  _reload: (feedId) ->

    @props.dispatch ArticleActions.fetchByFeed feedId

  _loadMore: ->

    nextPage = @props.articles.page + 1
    feedId = @props.params.feedId

    @props.dispatch ArticleActions.fetchByFeed feedId, nextPage

  _onClick: (article) ->

    @props.dispatch ArticleActions.fetchContent article
