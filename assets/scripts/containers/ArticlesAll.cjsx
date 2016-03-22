React = require 'react'
{ connect } = require 'react-redux'
ArticleActions = require '../actions/ArticleActions'
Article = require '../components/Article'

mapStateToProps = (state) ->
  articles: state.articles
  subscriptions: state.subscriptions

module.exports = connect(mapStateToProps) React.createClass

  getInitialState: ->

    subscriptionsByFeedId: {}

  componentWillMount: ->

    @_populateFeeds @props.subscriptions

    @props.dispatch ArticleActions.fetchAll()

  componentWillReceiveProps: (nextProps) ->

    if nextProps.subscriptions
      @_populateFeeds nextProps.subscriptions

  render: ->

    <ul className='articlesList'>
      { @props.articles.map @_renderArticle }
    </ul>

  _populateFeeds: (subscriptions) ->

    subscriptionsByFeedId = {}

    subscriptions.forEach (subscription) ->
      subscriptionsByFeedId[subscription.feed._id] = subscription

    @setState { subscriptionsByFeedId }

  _renderArticle: (article, i) ->

    <li key={ i }>
      <Article
        article={ article }
        subscription={ @state.subscriptionsByFeedId[article.feed] } />
    </li>
