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

    subscriptionTitle = @_getSubscriptionTitleFromFeedId @props.params.feedId

    <ArticleList
      loadMore={ @_loadMore }
      articles={ @props.articles }
      onClick={ @_onClick }
      title={ subscriptionTitle } />

  _reload: (feedId) ->

    @props.dispatch ArticleActions.fetchByFeed feedId

  _loadMore: ->

    nextPage = @props.articles.page + 1
    feedId = @props.params.feedId

    @props.dispatch ArticleActions.fetchByFeed feedId, nextPage

  _onClick: (article) ->

    @props.dispatch ArticleActions.fetchContent article

  # Attempts to get the title of the current subscription. If there are no
  # subscriptions in the store it'll return a blank string.
  _getSubscriptionTitleFromFeedId: (feedId) ->

    sub = @props.subscriptions.find (subscription, i) =>
      subscription.feed._id is feedId

    unless sub
      return ''

    sub.customTitle or sub.feed.title
