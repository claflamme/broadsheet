React = require 'react'
{ Navbar } = require 'react-bootstrap'
{ connect } = require 'react-redux'
ArticleActions = require '../actions/ArticleActions'
ArticleList = require '../components/ArticleList.cjsx'

mapStateToProps = (state) ->

  articles: state.articles

module.exports = connect(mapStateToProps) React.createClass

  componentWillMount: ->

    @props.dispatch ArticleActions.fetchAll()

  render: ->

    <ArticleList
      loadMore={ @_loadMore }
      articles={ @props.articles } />

  _loadMore: ->

    nextPage = @props.articles.page + 1

    @props.dispatch ArticleActions.fetchAll nextPage
