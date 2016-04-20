React = require 'react'
{ Button } = require 'react-bootstrap'
ArticleListItem = require './ArticleListItem'
Loader = require './Loader'

ArticleList = (props, context) ->

  hasDocs = props.articles.docs.length > 0

  <div className='articlesListContainer'>
    <Loader show={ props.articles.loading } />
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

  if props.articles.loading
    return null

  text = 'Load more...'
  finished = props.articles.page is props.articles.pages

  if finished
    text = 'That\'s all, folks!'

  <Button disabled={ finished } block onClick={ props.loadMore }>
    { text }
  </Button>

module.exports = ArticleList
