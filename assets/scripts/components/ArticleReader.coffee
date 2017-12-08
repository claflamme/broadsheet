React = require 'react'
{ Component } = React
el = React.createElement
pt = require 'prop-types'
{ Button } = require 'react-bootstrap'
moment = require 'moment'

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

class ArticleReader extends Component

  @propTypes:
    reader: pt.object
    show: pt.bool
    hideReader: pt.func

  componentDidUpdate: ->
    adjustImages()

  render: ->
    unless @props.reader.doc
      return @renderPlaceholder()

    buttonProps =
      block: true
      bsStyle: 'primary'
      bsSize: 'large'
      className: 'article-close-button text-center'
      onClick: @props.onHide

    articleWrapperClasses = [
      'article-wrapper'
      if @props.show then 'show-mobile-reader'
      'slide'
      if @props.reader.body then 'up'
    ]

    el 'div', className: articleWrapperClasses.join(' '),
      el 'div', className: "article-body",
        el 'div', null,
          el Button, buttonProps,
            el 'i', className: 'fa fa-arrow-left'
            ' Back'
          el 'h1', null,
            el 'a', href: (@props.reader.doc?.url or ''), target: '_blank',
              @props.reader.doc?.title or ''
          @renderSubscription()
          @renderDate @props.reader.doc?.publishedAt
          el 'div', onClick: @onArticleClick, dangerouslySetInnerHTML: { __html: @props.reader.body }

  renderPlaceholder: ->
    el 'div', className: 'article-placeholder',
      el 'p', className: 'text-muted',
        'Select an article from the left.'

  onArticleClick: (e) ->
    if e.target.href
      e.preventDefault()
      window.open e.target.href

  renderDate: (date) ->
    verbose = moment(date).format 'dddd, MMMM Do, YYYY'
    short = moment(date).fromNow()

    el 'p', className: 'text-muted',
      el 'em', null,
        "#{ short }—#{ verbose }"

  renderSubscription: ->
    sub = @props.subscriptions.docs.find (sub) =>
      sub.feed._id is @props.reader.doc.feed

    el 'div', className: 'text-muted',
      el 'span', style: { textTransform: 'uppercase' },
        sub.customTitle or sub.feed.title
      if @props.reader.doc.author
        el 'span', null,
          ' by '
          @props.reader.doc.author

module.exports = ArticleReader
