React = require 'react'
ArticleListItem = require './ArticleListItem'
Button = require '../elements/Button'
Loader = require './Loader'

ArticleList = (props, context) ->

  hasDocs = props.articles.docs.length > 0

  <div className='articlesListContainer'>
    <Loader show={ props.articles.loading and not hasDocs } />
    <ul className={ "articlesList slide #{ if hasDocs then 'up' }" }>
      { props.articles.docs.map renderArticle.bind null, props }
    </ul>
    <p></p>
    { renderLoadMore props }
    <p></p>
  </div>

ArticleList.propTypes =

  articles: React.PropTypes.object.isRequired
  loadMore: React.PropTypes.func.isRequired
  onClick: React.PropTypes.func.isRequired

renderArticle = (props, article, i) ->

  className = if article._id is props.currentArticle?._id then 'active' else ''

  <li
    key={ i }
    onClick={ props.onClick.bind null, article }
    className="#{ className }">
    <ArticleListItem article={ article } />
  </li>

renderLoadMore = (props) ->

  if props.articles.loading and props.articles.docs.length is 0
    return null

  text = 'Load more...'
  isFinished = props.articles.page is props.articles.pages

  if props.articles.loading
    text = 'Loading...'

  if isFinished
    text = 'That\'s all, folks!'

  <Button
    disabled={ isFinished or props.articles.loading }
    block
    bsStyle='primary'
    onClick={ props.loadMore }>
    { text }
  </Button>

module.exports = ArticleList
