React = require 'react'
Loader = require './Loader'

ArticleReader = (props, context) ->

  unless props.reader.doc
    return renderPlaceholder()

  <div className='articleWrapper'>
    <div className='articleBody'>
      <h1>
        <a
          href={ props.reader.doc?.url or '' }
          target='_blank'
          dangerouslySetInnerHTML={{ __html: props.reader.doc?.title or '' }}>
        </a>
      </h1>
      <Loader show={ props.reader.loading } />
      <div
        className={ "slide #{ if props.reader.body then 'up' }" }
        dangerouslySetInnerHTML={ { __html: props.reader.body } }>
      </div>
    </div>
  </div>

ArticleReader.propTypes =

  reader: React.PropTypes.object

renderPlaceholder = ->

  <div className='articlePlaceholder'>
    <p className='text-muted'>
      Select an article from the left.
    </p>
  </div>

module.exports = ArticleReader
