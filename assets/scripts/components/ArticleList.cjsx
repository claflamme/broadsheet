React = require 'react'
{ Navbar } = require 'react-bootstrap'
ArticleActions = require '../actions/ArticleActions'
Article = require './Article'

module.exports = React.createClass

  propTypes:

    articles: React.PropTypes.array

  getDefaultProps: ->

    articles: []

  render: ->

    <ul className='articlesList'>
      { @props.articles.map @_renderArticle }
    </ul>

  _renderArticle: (article, i) ->

    <li key={ i }>
      <Article article={ article } />
    </li>
