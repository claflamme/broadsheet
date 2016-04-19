React = require 'react'

ArticleReader = (props, context) ->

  unless props.article
    return renderPlaceholder()

  <div className='articleWrapper'>
    <div className='articleBody'>
      <h1>
        <a
          href={ props.article?.url or '' }
          target='_blank'
          dangerouslySetInnerHTML={{ __html: props.article?.title or '' }}>
        </a>
      </h1>
      <div dangerouslySetInnerHTML={ { __html: props.articleBody } }></div>
    </div>
  </div>

ArticleReader.propTypes =

  article: React.PropTypes.object
  articleBody: React.PropTypes.string

renderPlaceholder = ->

  <div className='articlePlaceholder'>
    <p className='text-muted'>
      Select an article from the left to read it.
    </p>
  </div>

module.exports = ArticleReader
