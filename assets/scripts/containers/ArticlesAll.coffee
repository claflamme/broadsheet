React = require 'react'
{ Component } = React
{ connect } = require 'react-redux'
fromPairs = require 'lodash/fromPairs'
ArticleActions = require '../actions/ArticleActions'
ArticleList = require '../components/ArticleList'

class ArticlesAll extends Component

  componentWillMount: ->
    @props.dispatch ArticleActions.fetchAll clearDocs: true

  render: ->
    subscriptionsList = @props.subscriptions.docs
    articleList = @props.articles.docs

    articleListProps =
      loadMore: @_loadMore
      articles: @_mapSubsToArticles subscriptionsList, articleList
      currentArticle: @props.reader.doc
      onClick: @_onClick

    React.createElement ArticleList, Object.assign(articleListProps, @props)

  _loadMore: =>
    nextPage = @props.articles.page + 1

    @props.dispatch ArticleActions.fetchAll page: nextPage

  _onClick: (article) =>
    @props.dispatch ArticleActions.fetchContent article

  _mapSubsToArticles: (subscriptionsList, articleList) ->
    # A hash of subscriptions, where keys are a subscription's feed ID and
    # values are the subscriptions themselves.
    subsByFeedId = fromPairs subscriptionsList.map (subscription) ->
      [subscription.feed._id, subscription]

    articleList.map (article) ->
      Object.assign article, { subscription: subsByFeedId[article.feed] }

module.exports = ArticlesAll
