React = require 'react'
el = React.createElement
pt = require 'prop-types'
{ Grid, Row, Col } = require 'react-bootstrap'
{ connect } = require 'react-redux'

Subscriptions = require '../components/Subscriptions'
ArticleReader = require '../components/ArticleReader'
ArticleList = require '../components/ArticleList'
FeedTitleBar = require '../components/FeedTitleBar'

Reader = (props) ->
  feedTitleBarProps =
    title: props.title
    dispatch: props.dispatch
    showControls: props.showControls
    subscription: props.subscription
    showEditSub: props.modals.showEditSub
    showDeleteSub: props.modals.showDeleteSub

  articleListProps =
    loadMore: props.loadMoreArticles
    articles: props.articles
    currentArticle: props.reader.doc
    onClick: props.onArticleClick

  articleReaderProps =
    show: props.reader.showMobileReader
    onHide: props.hideReader
    reader: props.reader
    subscriptions: props.subscriptions

  el 'div', style: { height: '100%' },
    el Col, xs: 12, sm: 9, lg: 4, className: 'article-list-col dashboard-col',
      el FeedTitleBar, feedTitleBarProps
      el ArticleList, articleListProps
    el Col, xs: 12, lg: 6, className: 'articleContent dashboard-col',
      el ArticleReader, articleReaderProps

Reader.propTypes =
  title: pt.string
  loadMoreArticles: pt.func
  onArticleClick: pt.func
  hideReader: pt.func
  showControls: pt.bool
  subscription: pt.object

module.exports = Reader
