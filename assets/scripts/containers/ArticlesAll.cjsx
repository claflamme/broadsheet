React = require 'react'
{ connect } = require 'react-redux'
ArticleActions = require '../actions/ArticleActions'
Reader = require '../components/Reader'

module.exports = ArticlesAll = React.createClass

  componentWillMount: ->

    @props.dispatch ArticleActions.fetchAll()

  render: ->

    childProps =
      title: 'All subscriptions'
      loadMoreArticles: @_loadMore
      onArticleClick: @_onClick
      hideReader: @_hideReader

    React.createElement Reader, Object.assign(childProps, @props)

  _loadMore: ->

    nextPage = @props.articles.page + 1

    @props.dispatch ArticleActions.fetchAll page: nextPage

  _onClick: (article) ->

    @props.dispatch ArticleActions.fetchContent article

  _hideReader: ->

    @props.dispatch ArticleActions.hideReader()
