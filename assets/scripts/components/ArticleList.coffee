React = require 'react'
el = React.createElement
pt = require 'prop-types'
{ Button } = require 'react-bootstrap'
ArticleListItem = require './ArticleListItem'
Loader = require './Loader'

onArticleClick = (e) ->
  unless e.metaKey
    e.preventDefault()

renderArticle = (props, article, i) ->
  className = if article._id is props.currentArticle?._id then 'active' else ''

  liProps =
    key: i
    onClick: props.onClick.bind null, article
    className: "article-list-item #{ className }"

  el 'li', liProps,
    el 'a', href: article.url, onClick: onArticleClick, title: article.title,
      el ArticleListItem, article: article

renderLoadMore = (props) ->
  if props.articles.loading and props.articles.docs.length is 0
    return null

  text = el 'div', {},
    "Load more "
    el 'i', className: 'fa fa-fw fa-arrow-down'

  isFinished = props.articles.page is props.articles.pages

  if props.articles.loading
    text = 'Loading...'

  if isFinished
    text = 'That\'s all, folks!'

  buttonProps =
    disabled: isFinished or props.articles.loading
    className: 'my-1'
    bsStyle: 'primary'
    block: true
    onClick: props.loadMore

  el Button, buttonProps,
    text

ArticleList = (props, context) ->
  hasDocs = props.articles.docs.length > 0

  el 'div', className: 'article-list-container dashboard-col',
    el Loader, show: (props.articles.loading and not hasDocs)
    el 'ul', className: "article-list slide #{ if hasDocs then 'up' }",
      props.articles.docs.map renderArticle.bind null, props
    renderLoadMore props

ArticleList.propTypes =
  articles: pt.object.isRequired
  loadMore: pt.func.isRequired
  onClick: pt.func.isRequired

module.exports = ArticleList
