React = require 'react'

FeedTitle = (props, context) ->

  <div className='feedTitleBar'>
    <h3 className='feedTitle'>{ props.title }</h3>
    { if props.showControls then renderControls() }
  </div>

FeedTitle.propTypes =
  title: React.PropTypes.string.isRequired
  showControls: React.PropTypes.bool
  subscription: React.PropTypes.object

renderControls = ->

  <span>
    <span>[ Edit ]</span>
    &nbsp;
    <span>[ Delete ]</span>
  </span>

module.exports = FeedTitle
