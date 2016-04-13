React = require 'react'
{ Button } = require 'react-bootstrap'
ArticleListItem = require './ArticleListItem'

ArticleList = (props, context) ->

  <div className='articlesListContainer'>
    <ul className='articlesList'>
      { props.articles.docs.map renderArticle.bind null, props.onClick }
    </ul>
    <p></p>
    { renderLoadMore props }
    <p></p>
  </div>

ArticleList.propTypes =

  articles: React.PropTypes.object.isRequired
  loadMore: React.PropTypes.func.isRequired
  onClick: React.PropTypes.func.isRequired

renderArticle = (onClick, article, i) ->

  <li key={ i } onClick={ onClick.bind null, article }>
    <ArticleListItem article={ article } />
  </li>

renderLoadMore = (props) ->

  text = 'Load more...'
  finished = props.articles.page is props.articles.pages

  if finished
    text = 'That\'s all, folks!'

  <Button disabled={ finished } block onClick={ props.loadMore }>
    { text }
  </Button>

module.exports = ArticleList
