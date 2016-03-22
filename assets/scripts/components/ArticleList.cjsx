React = require 'react'
{ Navbar } = require 'react-bootstrap'
ArticleActions = require '../actions/ArticleActions'
Article = require './Article'

module.exports = React.createClass

  propTypes:

    articles: React.PropTypes.array
    subscriptions: React.PropTypes.array

  getDefaultProps: ->

    articles: []
    subscriptions: []

  getInitialState: ->

    subscriptionsByFeedId: {}

  componentWillMount: ->

    @_populateFeeds @props.subscriptions

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
