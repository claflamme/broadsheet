React = require 'react'
{ Button } = require 'react-bootstrap'
Article = require './Article'

ArticleList = (props, context) ->

  <div>
    <ul className='articlesList'>
      { props.articles.docs.map renderArticle }
    </ul>
    <p></p>
    { renderLoadMore props }
    <p></p>
  </div>

ArticleList.propTypes =
  articles: React.PropTypes.object.isRequired
  loadMore: React.PropTypes.func.isRequired
  durf: React.PropTypes.func.isRequired

renderArticle = (article, i) ->

  <li key={ i }>
    <Article article={ article } />
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
