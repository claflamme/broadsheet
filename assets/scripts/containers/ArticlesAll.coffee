React = require 'react'
{ connect } = require 'react-redux'
fromPairs = require 'lodash/fromPairs'
ArticleActions = require '../actions/ArticleActions'
Reader = require '../components/Reader'

module.exports = ArticlesAll = React.createClass

  componentWillMount: ->
    @props.dispatch ArticleActions.fetchAll clearDocs: true

  render: ->
    subscriptionsList = @props.subscriptions.docs
    articlesList = @props.articles.docs

    childProps =
      title: 'All subscriptions'
      loadMoreArticles: @_loadMore
      onArticleClick: @_onClick
      hideReader: @_hideReader
      articles: @_mapSubsToArticles subscriptionsList, articlesList

    React.createElement Reader, Object.assign(childProps, @props)

  _loadMore: ->
    nextPage = @props.articles.page + 1

    @props.dispatch ArticleActions.fetchAll page: nextPage

  _onClick: (article) ->
    @props.dispatch ArticleActions.fetchContent article

  _hideReader: ->
    @props.dispatch ArticleActions.hideReader()

  _mapSubsToArticles: (subscriptionsList, articlesList) ->
    # A hash of subscriptions, where keys are a subscription's feed ID and
    # values are the subscriptions themselves.
    subsByFeedId = fromPairs subscriptionsList.map (subscription) ->
      [subscription.feed._id, subscription]

    articlesList.map (article) ->
      Object.assign article, { subscription: subsByFeedId[article.feed] }
