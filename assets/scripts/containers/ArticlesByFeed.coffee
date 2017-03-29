React = require 'react'
{ connect } = require 'react-redux'
ArticleActions = require '../actions/ArticleActions'
Reader = require '../components/Reader'

module.exports = ArticlesByFeed = React.createClass

  componentWillMount: ->
    @_reload @props.params.feedId

  componentWillReceiveProps: (nextProps) ->
    if nextProps.params.feedId isnt @props.params.feedId
      @_reload nextProps.params.feedId

  render: ->
    subscription = @_getActiveSubscription @props.params.feedId

    childProps =
      title: subscription?.customTitle or subscription?.feed.title
      loadMoreArticles: @_loadMore
      onArticleClick: @_onClick
      hideReader: @_hideReader
      showControls: true
      subscription: subscription

    React.createElement Reader, Object.assign(childProps, @props)

  _reload: (feedId) ->
    @props.dispatch ArticleActions.fetchByFeed feedId, { clearDocs: true }

  _loadMore: ->
    nextPage = @props.articles.page + 1
    feedId = @props.params.feedId

    @props.dispatch ArticleActions.fetchByFeed feedId, { page: nextPage }

  _onClick: (article) ->
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

  _hideReader: ->
    @props.dispatch ArticleActions.hideReader()
