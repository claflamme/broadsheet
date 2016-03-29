React = require 'react'
{ Button } = require 'react-bootstrap'
ArticleActions = require '../actions/ArticleActions'
Article = require './Article'

module.exports = React.createClass

  propTypes:

    articles: React.PropTypes.object.isRequired
    loadMore: React.PropTypes.func.isRequired

  render: ->

    <div>
      <ul className='articlesList'>
        { @props.articles.docs.map @_renderArticle }
      </ul>
      <p></p>
      { @_renderLoadMore() }
      <p></p>
    </div>

  _renderArticle: (article, i) ->

    <li key={ i }>
      <Article article={ article } />
    </li>

  _renderLoadMore: ->

    text = 'Load more...'
    finished = @props.articles.page is @props.articles.pages

    if finished
      text = 'That\'s all, folks!'

    <Button disabled={ finished } block onClick={ @props.loadMore }>
      { text }
    </Button>
