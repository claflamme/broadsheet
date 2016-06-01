React = require 'react'
Loader = require './Loader'

ArticleReader = React.createClass

  propTypes:
    reader: React.PropTypes.object

  componentDidUpdate: ->

    adjustLazyLoadedImages()

  render: ->

    unless @props.reader.doc
      return renderPlaceholder()

    <div className='articleWrapper'>
      <div className='articleBody'>
        <Loader show={ @props.reader.loading } />
        <div className={ "slide #{ if @props.reader.body then 'up' }" }>
          <h1>
            <a
              href={ @props.reader.doc?.url or '' }
              target='_blank'>
                { @props.reader.doc?.title or '' }
            </a>
          </h1>
          <div
            onClick={ onArticleClick }
            dangerouslySetInnerHTML={{ __html: @props.reader.body }}>
          </div>
        </div>
      </div>
    </div>

# This is a quick fix for sites using plugins like "lazysizes" to lazy-load
# their images. It converts data attributes for `src` and `srcset` to their
# normal non-data attributes.
adjustLazyLoadedImages = ->

  imageNodesList = document.querySelectorAll '.articleBody img'

  Array.prototype.slice.call(imageNodesList).forEach (imageNode) ->
    ['src', 'srcset'].forEach (attr) ->
      if imageNode.dataset[attr]
        imageNode[attr] = imageNode.dataset[attr]

renderPlaceholder = ->

  <div className='articlePlaceholder'>
    <p className='text-muted'>
      Select an article from the left.
    </p>
  </div>

onArticleClick = (e) ->

  if e.target.href
    e.preventDefault()
    window.open e.target.href

module.exports = ArticleReader
