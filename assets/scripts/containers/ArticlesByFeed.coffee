React = require 'react'
{ Component } = React
{ connect } = require 'react-redux'
ArticleActions = require '../actions/ArticleActions'
ArticleList = require '../components/ArticleList'

class ArticlesByFeed extends Component

  componentWillMount: ->
    @_reload @props.params.feedId

  componentWillReceiveProps: (nextProps) ->
    if nextProps.params.feedId isnt @props.params.feedId
      @_reload nextProps.params.feedId

  render: ->
    articleListProps =
      loadMore: @_loadMore
      articles: @props.articles
      currentArticle: @props.reader.doc
      onClick: @_onClick

    React.createElement ArticleList, Object.assign(articleListProps, @props)

  _reload: (feedId) ->
    @props.dispatch ArticleActions.fetchByFeed feedId, { clearDocs: true }

  _loadMore: =>
    nextPage = @props.articles.page + 1
    feedId = @props.params.feedId

    @props.dispatch ArticleActions.fetchByFeed feedId, { page: nextPage }

  _onClick: (article) =>
    @props.dispatch ArticleActions.fetchContent article

  _getActiveSubscription: (feedId) ->
    @props.subscriptions.docs.find (subscription, i) ->
      subscription.feed._id is feedId

  # Attempts to get the title of the current subscription. If there are no
  # subscriptions in the store it'll return a blank string.
  _getActiveSubscriptionTitle: (feedId) ->
    sub = @_getSubscription feedId

    unless sub
      return ''

    sub.customTitle or sub.feed.title

module.exports = ArticlesByFeed
