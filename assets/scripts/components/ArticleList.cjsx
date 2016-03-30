React = require 'react'
{ Button } = require 'react-bootstrap'
Article = require './Article'

# Main render Method
# ------------------------------------------------------------------------------

ArticleList = (props, context) ->

  <div>
    <ul className='articlesList'>
      { props.articles.docs.map renderArticle.bind(null, props.onClick) }
    </ul>
    <p></p>
    { renderLoadMore props }
    <p></p>
  </div>

# Component metadata
# ------------------------------------------------------------------------------

ArticleList.propTypes =

  articles: React.PropTypes.object.isRequired
  loadMore: React.PropTypes.func.isRequired
  onClick: React.PropTypes.func.isRequired

# Helpers
# ------------------------------------------------------------------------------

renderArticle = (onClick, article, i) ->

  <li key={ i } onClick={ onClick.bind null, article }>
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
