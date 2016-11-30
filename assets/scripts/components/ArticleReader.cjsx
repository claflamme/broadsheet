React = require 'react'
{ Button } = require 'react-bootstrap'
moment = require 'moment'

Loader = require './Loader'

# --- Helpers ------------------------------------------------------------------

# Some sites use lazy loaders that store image src/srcset attributes in data
# attributes. This function pulls those out, assigns them to their non-data
# equivalents, and proxies requests for insecure images.
adjustImages = ->

  imageNodesList = document.querySelectorAll '.article-body img'

  Array.prototype.slice.call(imageNodesList).forEach (imageNode) ->

    ['src', 'srcset'].forEach (attr) ->
      if imageNode.dataset[attr]
        imageNode[attr] = imageNode.dataset[attr]

    imageNode.src = fixInsecureSrc imageNode.src
    imageNode.srcset = fixInsecureSrcSet imageNode.srcset

# Replaces an insecure image src with a proxy URL.
fixInsecureSrc = (src) ->

  if src.substring(0, 7) isnt 'http://'
    return src

  "/api/proxy?url=#{ src }"

# Parses out the srcset and fixes up and insecure src attributes.
fixInsecureSrcSet = (srcset) ->

  sizeList = srcset.split ','

  sizeList = sizeList.map (size) ->
    size = size.trim().split ' '
    size[0] = fixInsecureSrc size[0]
    size.join ' '

  sizeList.join ','

# --- Component ----------------------------------------------------------------

ArticleReader = React.createClass

  propTypes:
    reader: React.PropTypes.object
    show: React.PropTypes.bool
    hideReader: React.PropTypes.func

  componentDidUpdate: ->

    adjustImages()

  render: ->

    unless @props.reader.doc
      return @renderPlaceholder()

    <div className="article-wrapper #{ if @props.show then 'show-mobile-reader' else '' }">
      <div className='article-body'>
        <Loader show={ @props.reader.loading } />
        <div className={ "slide #{ if @props.reader.body then 'up' }" }>
          <Button
            block
            bsStyle='primary'
            className='article-close-button text-center'
            onClick={ @props.onHide }>
            <i className='fa fa-arrow-left'>&nbsp;</i>
            Back
          </Button>
          <h1>
            <a
              href={ @props.reader.doc?.url or '' }
              target='_blank'>
                { @props.reader.doc?.title or '' }
            </a>
          </h1>
          { @renderSubscription() }
          { @renderDate @props.reader.doc?.publishedAt }
          <div
            onClick={ @onArticleClick }
            dangerouslySetInnerHTML={{ __html: @props.reader.body }}>
          </div>
        </div>
      </div>
    </div>

  renderPlaceholder: ->

    <div className='articlePlaceholder'>
      <p className='text-muted'>
        Select an article from the left.
      </p>
    </div>

  onArticleClick: (e) ->

    if e.target.href
      e.preventDefault()
      window.open e.target.href

  renderDate: (date) ->

    verbose = moment(date).format 'dddd, MMMM Do, YYYY'
    short = moment(date).fromNow()

    <p className='text-muted'>
      <em>
        { short }&mdash;{ verbose }
      </em>
    </p>

  renderSubscription: ->

    sub = @props.subscriptions.docs.find (sub) =>
      sub.feed._id is @props.reader.doc.feed

    <div className='text-muted' style={{textTransform:'uppercase'}}>
      { sub.customTitle or sub.feed.title }
    </div>

module.exports = ArticleReader
