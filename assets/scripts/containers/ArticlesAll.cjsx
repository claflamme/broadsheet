React = require 'react'
{ Navbar } = require 'react-bootstrap'
{ connect } = require 'react-redux'
ArticleActions = require '../actions/ArticleActions'
ArticleList = require '../components/ArticleList'
FeedTitleBar = require '../components/FeedTitleBar'

mapStateToProps = (state) ->

  articles: state.articles

module.exports = connect(mapStateToProps) React.createClass

  componentWillMount: ->

    @props.dispatch ArticleActions.fetchAll()

  render: ->

    <div>
      <FeedTitleBar title='All subscriptions' />
      <ArticleList
        loadMore={ @_loadMore }
        articles={ @props.articles }
        onClick={ @_onClick } />
    </div>

  _loadMore: ->

    nextPage = @props.articles.page + 1

    @props.dispatch ArticleActions.fetchAll nextPage

  _onClick: (article) ->

    @props.dispatch ArticleActions.fetchContent article
