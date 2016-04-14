React = require 'react'
{ Navbar } = require 'react-bootstrap'
{ connect } = require 'react-redux'
ArticleActions = require '../actions/ArticleActions'
ArticleList = require '../components/ArticleList'
FeedTitleBar = require '../components/FeedTitleBar'

mapStateToProps = (state) ->

  articles: state.articles
  subscriptions: state.subscriptions
  edit: state.modals.editSubscription

module.exports = connect(mapStateToProps) React.createClass

  componentWillMount: ->

    @_reload @props.params.feedId

  componentWillReceiveProps: (nextProps) ->

    if nextProps.params.feedId isnt @props.params.feedId
      @_reload nextProps.params.feedId

  render: ->

    subscription = @_getActiveSubscription @props.params.feedId

    unless subscription
      return null

    <div>
      <FeedTitleBar
        title={ subscription.customTitle or subscription.feed.title }
        showControls={ true }
        subscription={ subscription }
        showEdit={ @props.edit.show }
        dispatch={ @props.dispatch } />
      <ArticleList
        loadMore={ @_loadMore }
        articles={ @props.articles }
        onClick={ @_onClick } />
    </div>

  _reload: (feedId) ->

    @props.dispatch ArticleActions.fetchByFeed feedId

  _loadMore: ->

    nextPage = @props.articles.page + 1
    feedId = @props.params.feedId

    @props.dispatch ArticleActions.fetchByFeed feedId, nextPage

  _onClick: (article) ->

    @props.dispatch ArticleActions.fetchContent article

  _getActiveSubscription: (feedId) ->

    @props.subscriptions.find (subscription, i) ->
      subscription.feed._id is feedId

  # Attempts to get the title of the current subscription. If there are no
  # subscriptions in the store it'll return a blank string.
  _getActiveSubscriptionTitle: (feedId) ->

    sub = @_getSubscription feedId

    unless sub
      return ''

    sub.customTitle or sub.feed.title
